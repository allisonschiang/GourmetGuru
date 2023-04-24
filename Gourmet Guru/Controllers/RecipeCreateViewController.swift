//
//  RecipeCreateViewController.swift
//  Gourmet Guru
//
//  Created by Allison Chiang on 4/12/23.
//

import Foundation
import UIKit
import PhotosUI

class RecipeCreateViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var cookingTime: UITextField!
    @IBOutlet weak var Scroller: UIScrollView!//refers to scrolling view
    @IBOutlet weak var topBox: UITextView!//description
    @IBOutlet weak var middleBox: UITextView!//ingredients
    @IBOutlet weak var botBox: UITextView!//directions
    @IBOutlet weak var ImageBut: UIImageView!
    
    let cdm = CoreDataManager()
    
    
    var ScrollerHeight: Int = 0//getting starter height of scroller
    var botBoxStart: Int = 0 //getting the starter distance from the bottom of the box to bot of scroller
    var imageEmpty: Bool = true//a value to keep track whether or not the image has been changed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBox.delegate = self
        middleBox.delegate = self
        botBox.delegate = self
        ScrollerHeight = Int(Scroller.bounds.height)
        botBoxStart = ScrollerHeight - Int(botBox.convert(botBox.bounds, to: Scroller).maxY)
        
    }
    
    //This is a function that detects whether or not any of the UI text
    //views have changed, that includes adding or removing text
    //for our purposes this is done to see whether or not the bottom(directions) UI text view has gone off screen
    //if it has gone off screen it fixes the screen size and if
    //there is too much white space from removing alot of text then it will
    //reduce the screen size
    func textViewDidChange(_ textView: UITextView) {
        // Calculate the bottom position of the botBox relative to the Scroller
        let botBoxBottom = botBox.convert(botBox.bounds, to: Scroller).maxY
        let botBoxint = Int(botBoxBottom)
        // Calculate the height of the Scroller
        let scrollerHeight = ScrollerHeight
        // Check if the botBox has gone off the screen
        if botBoxint > scrollerHeight {
            let offScreenDistance = botBoxint - scrollerHeight
            
            Scroller.contentSize.height = Scroller.contentSize.height + CGFloat(offScreenDistance)
            
            ScrollerHeight = Int(Scroller.contentSize.height)
        } else {
            if(botBoxint < scrollerHeight){
                let offset = scrollerHeight - botBoxint
                let over = abs(botBoxStart - botBoxint)
                if offset>botBoxStart{
                    Scroller.contentSize.height = Scroller.contentSize.height - CGFloat(over)
                    ScrollerHeight = Int(Scroller.contentSize.height)
                }
            }
        }
    }
    
    
    @IBAction func didTappedDone(_ sender: Any) {
        var title: String = ""//title for alert controller and I must add "" to get around an error but it will never actually be empty
        var message: String = ""//body for alert controller and same as above ^^^
        var showAlert: Bool = false//whether or not we even show the alert
        var alertController: UIAlertController?
        
        if(imageEmpty){//is image empty?
            title = "Image Empty"
            message = "No image was select, please go back and select an image."
            showAlert = true
        }
        else if(recipeTitle.text == nil){//is title empty?
            title = "Title Empty"
            message = "No recipe title, please go back and name the recipe."
            showAlert = true
        }
        else if(cookingTime.text == nil){//do we have a cooking time?
            title = "Cooking Time Empty"
            message = "No cooking time indicated, please go back and fill out the cooking time"
            showAlert = true
        }
        else if(topBox.text.isEmpty){//do we have a descriptiion?
            title = "Description Empty"
            message = "No description filled out, please go back and make a description for the recipe"
            showAlert = true
        }
        else if(middleBox.text.isEmpty){//do we have ingredients?
            title = "Ingredients Empty"
            message = "No ingredients indicated, please go back and add ingredients for the recipe"
            showAlert = true
        }
        else if(botBox.text.isEmpty){//do we have directions?
            title = "Directions Empty"
            message = "No directions listed, please go back and add directions for the recipe"
            showAlert = true
        }
        //Basically if any of our fields are nil, we show a custom alert to let the user know what they need to fill out
        if(showAlert){
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .default){_ in
                alertController?.dismiss(animated: true, completion: nil)
            }
            alertController?.addAction(dismissAction)
            present(alertController!, animated: true, completion: nil)
            return
        }
        
        //if none of our fields are empty, we go ahead and add the recipe to the core data using our CoreDataManager
        //also there is alot of force unwrapping, but since I did those checks above, we should be good
        let timeZ = Int16(cookingTime.text!)! //Bunch of bullshit to convert to Int16, basically just spam hit 'fix'
        cdm.addRecipe(title: recipeTitle.text!, time: timeZ, foodDescription: topBox.text!, ingredients: middleBox.text!, directions: botBox.text!, image: ImageBut.image!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedAdd(_ sender: Any) {
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized {
            // Request photo library access
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                switch status {
                case .authorized:
                    // The user authorized access to their photo library
                    // show picker (on main thread)
                    DispatchQueue.main.async {
                        self?.presentImagePicker()
                    }
                default:
                    // show settings alert (on main thread)
                    DispatchQueue.main.async {
                        // Helper method to show settings alert
                        self?.presentGoToSettingsAlert()
                    }
                }
            }
        } else {
            // Show photo picker
            presentImagePicker()
        }
    }
    //everything below here dont worry about ^^^ thats the real headache
    
    private func presentImagePicker() {
        //create a configuration object
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        
        //Set the filter to only show images as options(i.e. no videos, ect.)
        config.filter = .images
        
        //request the original file format. Fastest method as it avoids transcoding.
        config.preferredAssetRepresentationMode = .current
        
        //Only allow 1 image to be selected at a time
        config.selectionLimit = 1
        
        //Instantiate a picker, passing in the configuration
        let picker = PHPickerViewController(configuration: config)
        
        //set the picker delegate so we can recieve whatever image the user picks
        picker.delegate = self
        
        //present the picker
        present(picker, animated: true)

    }
    
    func presentGoToSettingsAlert() {
        let alertController = UIAlertController (
            title: "Photo Access Required",
            message: "In order to post a photo to complete a task, we need access to your photo library. You can allow access in Settings",
            preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }

        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    /// Show an alert for the given error
    private func showAlert(for error: Error? = nil) {
        let alertController = UIAlertController(
            title: "Oops...",
            message: "\(error?.localizedDescription ?? "Please try again...")",
            preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)

        present(alertController, animated: true)
    }

    
    


}

extension RecipeCreateViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                
                // Get the selected image
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage, error == nil else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    // Set the image to your UIImageView
                    DispatchQueue.main.async {
                        self?.ImageBut.image = image
                    }
                }
        imageEmpty = false //once the image has been selected we go ahead and indicate it has been picked for error handling
    }
    
    
}

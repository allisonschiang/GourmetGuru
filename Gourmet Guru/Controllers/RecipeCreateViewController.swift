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

    @IBOutlet weak var Scroller: UIScrollView!
    @IBOutlet weak var topBox: UITextView!
    @IBOutlet weak var middleBox: UITextView!
    @IBOutlet weak var botBox: UITextView!
    @IBOutlet weak var ImageBut: UIImageView!
    
    
    var ScrollerHeight: Int = 0//getting starter height of scroller
    var botBoxStart: Int = 0 //getting the starter distance from the bottom of the box to bot of scroller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBox.delegate = self
        middleBox.delegate = self
        botBox.delegate = self
        ScrollerHeight = Int(Scroller.bounds.height)
        botBoxStart = ScrollerHeight - Int(botBox.convert(botBox.bounds, to: Scroller).maxY)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // This function will be called whenever the text in any of the UITextViews is changed
        // You can add your desired functionality here, like printing a message
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
    }
    
    
}

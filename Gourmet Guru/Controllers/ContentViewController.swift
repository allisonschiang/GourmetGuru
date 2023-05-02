//
//  ContentViewController.swift
//  Gourmet Guru
//
//  Created by Allison Chiang on 4/12/23.
//

import Foundation
import UIKit
import PhotosUI
import CoreData

class ContentViewController: UIViewController, UITextViewDelegate {
    
    
    var recipeObjectID: Recipe?
    
    

    @IBOutlet weak var Scroller: UIScrollView!
    @IBOutlet weak var ImageBut: UIImageView!
    @IBOutlet weak var donebutton: UIButton!
    
    //new connections
    @IBOutlet weak var recipeimage: UIImageView!
    @IBOutlet weak var recipename: UILabel!
    @IBOutlet weak var recipetime: UILabel!
    @IBOutlet weak var recipedescription: UILabel!
    @IBOutlet weak var recipeingredients: UILabel!
    @IBOutlet weak var recipedirections: UILabel!
    
    let cdm = CoreDataManager()
    var recipe:String?
    var ScrollerHeight: Int = 0
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetails" {
            let recipeDetailsVC = segue.destination as! ContentViewController
            if let recipe = sender as? Recipe {
                recipeDetailsVC.recipe = recipe.title
                recipename.text = recipeDetailsVC.recipe// or any other property of the Recipe object
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "SELF == %@", recipeObjectID!)
        ScrollerHeight = Int(Scroller.bounds.height)
        do {
            //let recipe = try context.fetch(fetchRequest).first
            let recipe = recipeObjectID
            if let recipe = recipe {
                recipename.text = recipe.title ?? ""
                recipetime.text = String(recipe.time)
                recipedescription.text = recipe.foodDescription
                recipeingredients.text = recipe.ingredients
                recipedirections.text = recipe.directions
                recipeimage.image = UIImage (data: recipe.image ?? Data())
                // Access other properties of the recipe object as needed
            } else {
                print("Failed to fetch recipe with objectID: \(recipeObjectID!)")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getScreenSize()
    }
    
    //quick function to make sure view will allow user to scroll through everything
    func getScreenSize(){
        print("Enter Functon")
        let recipeDirectionBottom = recipedirections.convert(recipedirections.bounds, to: Scroller).maxY
        let recipeDirectionint = Int(recipeDirectionBottom)
        let scrollerHeight = ScrollerHeight
        print (recipeDirectionint)
        print(scrollerHeight)
        if recipeDirectionint > scrollerHeight {
            let offScreenDistance = recipeDirectionint - scrollerHeight
            print("Off Screen Distance is \(offScreenDistance)")
            Scroller.contentSize.height = Scroller.contentSize.height + CGFloat(offScreenDistance + 20)
            
            ScrollerHeight = Int(Scroller.contentSize.height)
            print("New scroll size is \(ScrollerHeight)")
        }
    }
    @IBAction func didTappedDone(_ sender: Any) {
        dismiss(animated: true)
    }
    
        
        
    
    
    
  


    
    //This is a function that detects whether or not any of the UI text
    //views have changed, that includes adding or removing text
    //for our purposes this is done to see whether or not the bottom(directions) UI text view has gone off screen
    //if it has gone off screen it fixes the screen size and if
    //there is too much white space from removing alot of text then it will
    //reduce the screen size
    
}
    
    
   
    
    //everything below here dont worry about ^^^ thats the real headache
    
  
    



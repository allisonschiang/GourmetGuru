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
    
    var ScrollerHeight: Int = 0//getting starter height of scroller
    var botBoxStart: Int = 0 //getting the starter distance from the bottom of the box to bot of scroller
    var imageEmpty: Bool = true//a value to keep track whether or not the image has been changed
    
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

        
        //topBox.delegate = self
       // middleBox.delegate = self
        //botBox.delegate = self
        //ScrollerHeight = Int(Scroller.bounds.height)
        //botBoxStart = ScrollerHeight - Int(botBox.convert(botBox.bounds, to: Scroller).maxY)
        
        
    
    
    
  


    
    //This is a function that detects whether or not any of the UI text
    //views have changed, that includes adding or removing text
    //for our purposes this is done to see whether or not the bottom(directions) UI text view has gone off screen
    //if it has gone off screen it fixes the screen size and if
    //there is too much white space from removing alot of text then it will
    //reduce the screen size
    
}
    
    
   
    
    //everything below here dont worry about ^^^ thats the real headache
    
  
    



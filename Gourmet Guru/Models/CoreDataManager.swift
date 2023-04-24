//
//  CoreDataManager.swift
//  Gourmet Guru
//
//  Created by Samuel A. Benicewicz on 4/21/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipeGuruDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    } ()
    lazy var managedContext: NSManagedObjectContext = self.container.viewContext
    
    func save() {
        guard managedContext.hasChanges else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func addRecipe(title: String, time: Int16, foodDescription: String, ingredients: String, directions: String, image: UIImage) {
        let context = managedContext
        let recipe = Recipe(context: context)
        recipe.setValue(title, forKey: "title")
        recipe.setValue(time, forKey: "time")
        recipe.setValue(foodDescription, forKey: "foodDescription")
        recipe.setValue(ingredients, forKey: "ingredients")
        recipe.setValue(directions, forKey: "directions")
        recipe.setValue(image.jpegData(compressionQuality: 1.0), forKey: "image")
        save()
        print("Saved recipe to CoreData")
    }
}

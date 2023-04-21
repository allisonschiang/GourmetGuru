//
//  RecipeListViewController.swift
//  Gourmet Guru
//
//  Created by Samuel A. Benicewicz on 4/14/23.
//

import UIKit
import CoreData

class RecipeListViewController: UIViewController {
    
    static let reuseIdentifier = "cell"
    var itemsPerRow: CGFloat = 3
    let sectioningSet = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var recipesArr: [Recipe] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "RecipeListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RecipeListViewController.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Sample data to add to core data // NOTE: It will create a new item every time the app is launched
        //AppDelegate.sharedAppDelegate.coreDataManager.addRecipe(title: "Pizza", time: 25, foodDescription: "Most people like pizza. People who don't are weird. Pizza is good.", image: UIImage(systemName: "heart") ?? UIImage()) // You can change this data and uncomment it to add a new item
        getRecipes()
        collectionView.reloadData() // Reload with the new data
    }

}

extension RecipeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeListViewController.reuseIdentifier, for: indexPath) as! RecipeListCollectionViewCell
        let recipe = recipesArr[indexPath.row]
        let title = recipe.title ?? ""
        let time = recipe.time 
        let foodDescription = recipe.foodDescription ?? ""
        let image = recipe.image
        cell.configure(foodTitle: title, foodTime: time, foodImage: UIImage(data: image!) ?? UIImage(), foodDescription: foodDescription)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getRecipes() {
        let recipesRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
            let recipes = try context.fetch(recipesRequest)
            recipesArr = recipes
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectioningSet
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectioningSet.left
    }
}
//
//  RecipeListViewController.swift
//  Gourmet Guru
//
//  Created by Samuel A. Benicewicz on 4/14/23.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    static let reuseIdentifier = "cell"
    var itemsPerRow: CGFloat = 3
    let sectioningSet = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "RecipeListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RecipeListViewController.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension RecipeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Temporary placeholder
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeListViewController.reuseIdentifier, for: indexPath) as! RecipeListCollectionViewCell
        cell.configure(foodTitle: "Pizza", foodTime: 25, foodImage: "square.and.arrow.up.circle.fill", foodDescription: "This is a pizza. Most people enjoy this food in slices.") // Temporary placeholder data
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
}

extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectioningSet.left * (itemsPerRow + 1)
        let width = view.frame.width - paddingSpace
        let widthPerItem = width / itemsPerRow
        return CGSize(width: 100, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectioningSet
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectioningSet.left
    }
}

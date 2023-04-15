//
//  RecipeListCollectionViewCell.swift
//  Gourmet Guru
//
//  Created by Samuel A. Benicewicz on 4/14/23.
//

import UIKit

class RecipeListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodTime: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 40
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
        // Initialization code
    }
    
    func configure(foodTitle: String, foodTime: Int, foodImage: String, foodDescription: String) {
        self.foodImage.image = UIImage(systemName: foodImage)
        self.foodTitle.text = foodTitle
        self.foodTime.text = String(foodTime)
        self.foodDescription.text = foodDescription
    }

}

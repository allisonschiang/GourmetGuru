//
//  Recipe.swift
//  Gourmet Guru
//
//  Created by Allison Chiang on 4/12/23.
//

import Foundation
import UIKit

struct Recipe{
    let image: UIImage? //need to edit recipe creation to make image necessary
    let title: String
    let cook_time: String //may change this to integer for better formatting
    let description: String
    let ingredients: String
    let directions: String
}


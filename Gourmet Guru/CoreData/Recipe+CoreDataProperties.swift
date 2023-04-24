//
//  Recipe+CoreDataProperties.swift
//  Gourmet Guru
//
//  Created by Samuel A. Benicewicz on 4/21/23.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var time: Int16
    @NSManaged public var foodDescription: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var directions: String?
    @NSManaged public var image: Data?

}

extension Recipe : Identifiable {

}

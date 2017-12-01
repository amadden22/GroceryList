//
//  Grocery+CoreDataProperties.swift
//  GroceryList
//
//  Created by Aidan Madden on 11/30/17.
//  Copyright © 2017 Aidan Madden. All rights reserved.
//
//

import Foundation
import CoreData


extension Grocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocery> {
        return NSFetchRequest<Grocery>(entityName: "Grocery")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double

}

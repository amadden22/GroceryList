//
//  Grocery+CoreDataClass.swift
//  GroceryList
//
//  Created by Aidan Madden on 11/30/17.
//  Copyright © 2017 Aidan Madden. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Grocery)
public class Grocery: NSManagedObject {
    convenience init?(name: String?, price: Double) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        self.init(entity: Grocery.entity(), insertInto: managedContext)
        
        self.name = name
        self.price = price
        
    }
}

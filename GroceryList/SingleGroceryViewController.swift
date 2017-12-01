//
//  SingleGroceryViewController.swift
//  GroceryList
//
//  Created by Aidan Madden on 11/30/17.
//  Copyright © 2017 Aidan Madden. All rights reserved.
//

import UIKit

class SingleGroceryViewController: UIViewController{
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    var existingGrocery: Grocery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.delegate = self
        priceText.delegate = self
        nameText.text = existingGrocery?.name
        if let price = existingGrocery?.price{
            priceText.text = "\(price)"
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameText.resignFirstResponder()
        priceText.resignFirstResponder()
    }
    
    @IBAction func saveItem(_ sender: Any) {
        let name = nameText.text
        let priceBefore = priceText.text ?? ""
        let price = Double(priceBefore) ?? 0.0
        
        var grocery: Grocery?
        
        if let existingGrocery = existingGrocery{
            existingGrocery.name = name
            existingGrocery.price = price
            
            grocery = existingGrocery
        } else{
            grocery = Grocery(name:name, price:price)
        }
        
        if let grocery = grocery {
            do{
                let managedContext = grocery.managedObjectContext
                try managedContext?.save()
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("context could not be saved")
            }
        }
        
    }
    
}

extension SingleGroceryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

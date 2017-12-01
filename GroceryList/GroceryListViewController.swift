//
//  File.swift
//  GroceryList
//
//  Created by Aidan Madden on 11/30/17.
//  Copyright © 2017 Aidan Madden. All rights reserved.
//

import UIKit

import UIKit
import CoreData

class GroceryListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    
    let dateFormatter = DateFormatter()
    var groceries = [Grocery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .long
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        
        do {
            groceries = try managedContext.fetch(fetchRequest)
            
            listTableView.reloadData()
        } catch {
            print ("Fetch could not be performed.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGroceryItem(_ sender: Any) {
        performSegue(withIdentifier: "showGrocery", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleGroceryViewController,
            let selectedRow = self.listTableView.indexPathForSelectedRow?.row else{
                return
        }
        destination.existingGrocery = groceries[selectedRow]
    }
    
    func deleteGrocery(at indexPath: IndexPath){
        let grocery = groceries[indexPath.row]
        
        if let managedContext = grocery.managedObjectContext{
            managedContext.delete(grocery)
            
            do{
                try managedContext.save()
                self.groceries.remove(at: indexPath.row)
                listTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("delete failed")
                listTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
        }
    }
}

extension GroceryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "groceryItem", for: indexPath)
        let groceryText = cell.viewWithTag(1) as! UILabel
        let priceText = cell.viewWithTag(2) as! UILabel
        let grocery = groceries[indexPath.row]
        let food = grocery.name
        let price = grocery.price
        priceText.text = "$\(price)"
        groceryText.text = "\(food!)"
 
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteGrocery(at: indexPath)
        }
    }
}

extension GroceryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGrocery", sender: self)
    }
}


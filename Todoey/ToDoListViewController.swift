//
//  ViewController.swift
//  Todoey
//
//  Created by Phanindra on 09/06/18.
//  Copyright © 2018 Phanindra. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [String]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
            
        }
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected item is : \(itemArray[indexPath.row])")
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        }else{
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey List", message: "", preferredStyle: .alert)
        
        var textField : UITextField = UITextField()
        
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (UIAlertAction) in
            self.itemArray.append(textField.text!)
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }))
        
        alert.addTextField { (alertTextFeild) in
            textField = alertTextFeild
            alertTextFeild.placeholder = "Add new item"
            print("text inside : \(alertTextFeild.text)")
        }
        
       present(alert, animated: true, completion: nil)
        
        
    }
    

}


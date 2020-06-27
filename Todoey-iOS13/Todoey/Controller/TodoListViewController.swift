//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

//- With UserDefaults
//    let userDefaults = UserDefaults.standard

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
//        let newItem1 = Item()
//        newItem1.title = "Find Mike"
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//
//        itemArray = [newItem1, newItem2, newItem3]

//- With UserDefaults
//        if let itemArray = userDefaults.array(forKey: "TodoListArray") as? [String] {
//            self.itemArray = itemArray
//        }

        print(dataFilePath)
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        saveItems()
    }

    @IBAction func btnAddTapped(_ sender: Any) {
        var textField = UITextField()

        let alertVC = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {
                let newItem = Item()
                newItem.title = text

                self.itemArray.append(newItem)
                self.saveItems()

//- With UserDefaults
//                self.userDefaults.set(self.itemArray, forKey: "TodoListArray")

                self.tableView.reloadData()
            }
        }

        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item..."
            textField = alertTextField
        }

        alertVC.addAction(actionAdd)
        present(alertVC, animated: true)
    }

    // MARK: - Model manipulation methods
    func saveItems() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath)
        } catch {
            print(error.localizedDescription)
            return
        }
    }

    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath) {
            let decoder = PropertyListDecoder()

            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
}

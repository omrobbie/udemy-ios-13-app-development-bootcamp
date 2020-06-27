//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if let itemArray = userDefaults.array(forKey: "TodoListArray") as? [String] {
            self.itemArray = itemArray
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType
        accessoryType = accessoryType == .checkmark ? Optional.none : .checkmark
        tableView.cellForRow(at: indexPath)?.accessoryType = accessoryType ?? .none

        tableView.deselectRow(at: indexPath, animated: true)
        print(itemArray[indexPath.row])
    }

    @IBAction func btnAddTapped(_ sender: Any) {
        var textField = UITextField()

        let alertVC = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {
                self.itemArray.append(text)
                self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
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
}

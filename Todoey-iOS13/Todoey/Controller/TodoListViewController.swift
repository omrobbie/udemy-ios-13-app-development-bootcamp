//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class TodoListViewController: UITableViewController, UISearchBarDelegate {

//- With UserDefaults
//    let userDefaults = UserDefaults.standard

//- With FileManager
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent("Items.plist")

//- With CoreData
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    private var itemArray = [Item]()

//- With Realm
    var selectedCategory: CategoryRealm? {
        didSet {
            loadItems()
        }
    }

    private var itemArray: Results<ItemRealm>?
    private let realm = try! Realm()

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

//        print(dataFilePath)
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if let item = itemArray?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none

            let percentage = CGFloat(indexPath.row) / CGFloat(itemArray!.count)
            if let color = FlatSkyBlue().darken(byPercentage: percentage) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//- With CoreData
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        tableView.deselectRow(at: indexPath, animated: true)
//        tableView.reloadData()
//        saveItems()

//- With Realm
        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print(error.localizedDescription)
                return
            }

            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//- With CoreData
//        if editingStyle == .delete {
//            context.delete(itemArray[indexPath.row])
//            itemArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            saveItems()
//        }

//- With Realm
        if editingStyle == .delete {
            if let item = itemArray?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//- With CoreData
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDescriptor]
//        loadItems(with: request, predicate: predicate)

//- With Realm
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

    @IBAction func btnAddTapped(_ sender: Any) {
        var textField = UITextField()

        let alertVC = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {

//- With UserDefaults
//                self.userDefaults.set(self.itemArray, forKey: "TodoListArray")

//- With CoreData
//                let newItem = Item(context: self.context)
//                newItem.title = text
//                newItem.done = false
//                newItem.parentCategory = self.selectedCategory
//                self.itemArray.append(newItem)
//                self.saveItems()

//- With Realm
                let newItem = ItemRealm()
                newItem.title = text
                newItem.done = false
                newItem.dateCreated = Date()

                self.saveItems(item: newItem)
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
    func saveItems(item: ItemRealm) {
//- With FileManager
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath)
//        } catch {
//            print(error.localizedDescription)
//            return
//        }

//- With CoreData
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//            return
//        }

//- With Realm
        if let currentCategory = selectedCategory {
            do {
                try self.realm.write {
                    currentCategory.items.append(item)
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }

    func loadItems() {
//- With FileManager
//        if let data = try? Data(contentsOf: dataFilePath) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print(error.localizedDescription)
//                return
//            }
//        }

//- With CoreData
// func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory?.name!)
//
//        if let predicate = predicate {
//            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//            request.predicate = compoundPredicate
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print(error.localizedDescription)
//            return
//        }

//- With Realm
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

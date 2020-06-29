//
//  CategoryViewController.swift
//  Todoey
//
//  Created by omrobbie on 28/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {

//- With CoreData
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    private var categories = [Category]()

//- With Realm
    private let realm = try! Realm()
    private var categories: Results<CategoryRealm>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.rowHeight = 120
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItem" {
            let vc = segue.destination as! TodoListViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                vc.selectedCategory = categories?[indexPath.row]
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories?[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }

    private func saveData(category: CategoryRealm) {
//- With CoreData
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//            return
//        }

//- With Realm
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }

    private func loadData(request: NSFetchRequest<Category> = Category.fetchRequest()) {
//- With CoreData
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print(error.localizedDescription)
//            return
//        }

//- With Realm
        categories = realm.objects(CategoryRealm.self)
        tableView.reloadData()

    }

    @IBAction func btnAddTapped(_ sender: Any) {
        var textField = UITextField()
        let alertVC = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add category", style: .default) { (action) in
//- With CoreData
//            let newCategory = Category(context: self.context)
//            newCategory.name = textField.text
//            self.categories.append(newCategory)

//- With Realm
            let newCategory = CategoryRealm()
            newCategory.name = textField.text!

            self.saveData(category: newCategory)
            self.tableView.reloadData()
        }

        alertVC.addTextField { (newCategory) in
            newCategory.placeholder = "Create new category..."
            textField = newCategory
        }

        alertVC.addAction(actionAdd)
        present(alertVC, animated: true)
    }
}

extension CategoryViewController: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("Item deleted!")
        }

        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
}

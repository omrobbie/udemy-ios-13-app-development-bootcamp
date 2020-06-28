//
//  CategoryViewController.swift
//  Todoey
//
//  Created by omrobbie on 28/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItem" {
            let vc = segue.destination as! TodoListViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                vc.selectedCategory = categories[indexPath.row]
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }

    private func saveData() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return
        }
    }

    private func loadData(request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return
        }
    }

    @IBAction func btnAddTapped(_ sender: Any) {
        var textField = UITextField()
        let alertVC = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text

            self.categories.append(newCategory)
            self.tableView.reloadData()
            self.saveData()
        }

        alertVC.addTextField { (newCategory) in
            newCategory.placeholder = "Create new category..."
            textField = newCategory
        }

        alertVC.addAction(actionAdd)
        present(alertVC, animated: true)
    }
}

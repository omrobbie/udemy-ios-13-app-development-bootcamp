//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!

    var messages: [Message] = [
        Message(sender: "putu.roby@yahoo.com", body: "Hi!"),
        Message(sender: "putu.roby@yahoo.com", body: "Di sini omrobbie.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appTitle
        navigationItem.hidesBackButton = true

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }

    @IBAction func btnLogoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellIdentifier) else {return UITableViewCell()}
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
}

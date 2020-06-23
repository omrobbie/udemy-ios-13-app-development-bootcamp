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

    let db = Firestore.firestore()

    var messages: [Message] = [
        Message(sender: "putu.roby@yahoo.com", body: "Hi!"),
        Message(sender: "putu.roby@yahoo.com", body: "Di sini omrobbie."),
        Message(sender: "putu.roby@yahoo.com", body: "Ini pesan yang sangat panjang untuk mencoba fleksibilitas tinggi dari teks chat.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appTitle
        navigationItem.hidesBackButton = true

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

        loadMessages()
    }

    func loadMessages() {
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            self.messages = []
            if let snapshotDocuments = querySnapshot?.documents {
                for doc in snapshotDocuments {
                    let data = doc.data()
                    if let sender = data[Constants.FStore.senderField] as? String,
                        let body = data[Constants.FStore.bodyField] as? String {
                        let newMessage = Message(sender: sender, body: body)
                        self.messages.append(newMessage)

                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,
            let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
                ]
            ) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                print("Successfully saved data.w")

                DispatchQueue.main.async {
                    self.messageTextfield.text = ""
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! MessageCell
        let item = messages[indexPath.row]
        cell.parseData(item: item)
        return cell
    }
}

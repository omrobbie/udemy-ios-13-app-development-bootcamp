//
//  QuoteTableViewController.swift
//  InspoQuotes
//
//  Created by Angela Yu on 18/08/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController {

    private let productID = "com.omrobbie.InspoQuotes.PremiumQuotes"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)

        if isPurchased() {
            showPremiumQuotes()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPurchased() {
            return quotesToShow.count
        } else {
            return quotesToShow.count + 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell")!

        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = .label
            cell.accessoryType = .none
            cell.backgroundColor = .systemBackground
        } else {
            cell.textLabel?.text = "Get More Quotes"
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .systemBlue
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
            tableView.deselectRow(at: indexPath, animated: true)
            buyPremiumQuotes()
        }
    }

    private func buyPremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("Sorry. You cannot make payments.")
        }
    }

    private func showPremiumQuotes() {
        UserDefaults.standard.set(true, forKey: productID)
        quotesToShow.append(contentsOf: premiumQuotes)
        tableView.reloadData()
    }

    private func isPurchased() -> Bool {
        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)

        if  purchaseStatus {
            print("Previously purchased")
            return true
        } else {
            print("Never purchased")
            return false
        }
    }

    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension QuoteTableViewController: SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Transaction successful!")
                SKPaymentQueue.default().finishTransaction(transaction)
                showPremiumQuotes()

            case .failed:
                print("Transaction failed!")

                if let error = transaction.error {
                    print(error.localizedDescription)
                }

                SKPaymentQueue.default().finishTransaction(transaction)

            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                showPremiumQuotes()
                navigationItem.setRightBarButton(nil, animated: true)

            default: break
            }
        }
    }
}

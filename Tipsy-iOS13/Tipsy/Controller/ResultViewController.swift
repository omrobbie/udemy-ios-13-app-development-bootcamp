//
//  ResultViewController.swift
//  Tipsy
//
//  Created by omrobbie on 19/06/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDescriptions: UILabel!

    var total: Double?
    var people: String?
    var tip: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let total = total,
            let people = people,
            let tip = tip {
            lblTotal.text = String(format: "%.2f", total)
            lblDescriptions.text = "Split between \(people), with \(tip)% tip."
        }
    }

    @IBAction func btnRecalculateTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

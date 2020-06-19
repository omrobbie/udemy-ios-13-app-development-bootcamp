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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnRecalculateTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

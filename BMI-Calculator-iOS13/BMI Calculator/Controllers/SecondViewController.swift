//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by omrobbie on 19/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblAdvice: UILabel!

    var bmiValue: String?
    var advice: String?
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()

        lblBMI.text = bmiValue
        lblAdvice.text = advice
        view.backgroundColor = color
    }

    @IBAction func btnRecalculateTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

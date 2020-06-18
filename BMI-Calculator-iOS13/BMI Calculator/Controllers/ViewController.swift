//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sliderHeightChanged(_ sender: UISlider) {
        let value = String(format: "%.2f", sender.value)
        lblHeight.text = "\(value)m"
    }

    @IBAction func sliderWeightChanged(_ sender: UISlider) {
        let value = String(format: "%.0f", sender.value)
        lblWeight.text = "\(value)Kg"
    }
}

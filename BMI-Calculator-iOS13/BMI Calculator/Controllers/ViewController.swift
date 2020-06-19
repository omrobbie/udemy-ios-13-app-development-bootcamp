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
    @IBOutlet weak var sliderHeight: UISlider!
    @IBOutlet weak var sliderWeight: UISlider!

    var bmiValue = "0.0"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.bmiValue = bmiValue
        }
    }

    @IBAction func sliderHeightChanged(_ sender: UISlider) {
        let value = String(format: "%.2f", sender.value)
        lblHeight.text = "\(value)m"
    }

    @IBAction func sliderWeightChanged(_ sender: UISlider) {
        let value = String(format: "%.0f", sender.value)
        lblWeight.text = "\(value)Kg"
    }

    @IBAction func btnCalculateTapped(_ sender: Any) {
        let height = sliderHeight.value
        let weight = sliderWeight.value

        let bmi = weight / pow(height, 2)
        bmiValue = "\(bmi)"

        performSegue(withIdentifier: "goToResult", sender: self)
    }
}

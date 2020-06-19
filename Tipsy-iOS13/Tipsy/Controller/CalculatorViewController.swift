//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var txtBill: UITextField!
    @IBOutlet weak var btnTip0: UIButton!
    @IBOutlet weak var btnTip10: UIButton!
    @IBOutlet weak var btnTip20: UIButton!
    @IBOutlet weak var lblSplit: UILabel!
    @IBOutlet weak var stpSplit: UIStepper!

    var tipValue: Double = 0.0
    var result: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            let people = String(format: "%.0f", stpSplit.value)
            let tip = String(format: "%.0f", tipValue * 100)
            destinationVC.total = result
            destinationVC.people = people
            destinationVC.tip = tip
        }
    }

    @IBAction func btnTipTapped(_ sender: UIButton) {
        btnTip0.isSelected = false
        btnTip10.isSelected = false
        btnTip20.isSelected = false

        let tip = sender.currentTitle!

        if tip == "10%" {
            tipValue = 0.1
            btnTip10.isSelected = true
        } else if tip == "20%" {
            tipValue = 0.2
            btnTip20.isSelected = true
        } else {
            tipValue = 0.0
            btnTip0.isSelected = true
        }

        txtBill.endEditing(true)
    }

    @IBAction func stpSplitChanged(_ sender: Any) {
        lblSplit.text = String(format: "%.0f", stpSplit.value)
    }

    @IBAction func btnCalculateTapped(_ sender: Any) {
        let bill = txtBill.text ?? "0"
        let billValue = Double(bill) ?? 0

        result = (billValue + (billValue * tipValue)) / stpSplit.value
        performSegue(withIdentifier: "goToResult", sender: self)
    }
}

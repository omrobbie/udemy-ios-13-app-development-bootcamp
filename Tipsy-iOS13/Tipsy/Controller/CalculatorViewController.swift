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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnTipTapped(_ sender: UIButton) {
        btnTip0.isSelected = false
        btnTip10.isSelected = false
        btnTip20.isSelected = false

        let tip = sender.currentTitle!

        if tip == "10%" {
            btnTip10.isSelected = true
        } else if tip == "20%" {
            btnTip20.isSelected = true
        } else {
            btnTip0.isSelected = true
        }
    }

    @IBAction func stpSplitChanged(_ sender: Any) {
    }

    @IBAction func btnCalculateTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToResult", sender: self)
    }
}

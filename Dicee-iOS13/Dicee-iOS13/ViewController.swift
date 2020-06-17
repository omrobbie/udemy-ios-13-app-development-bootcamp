//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnRollTapped(_ sender: Any) {
        imgDice1.image = #imageLiteral(resourceName: "DiceFour")
        imgDice2.image = #imageLiteral(resourceName: "DiceThree")
    }
}

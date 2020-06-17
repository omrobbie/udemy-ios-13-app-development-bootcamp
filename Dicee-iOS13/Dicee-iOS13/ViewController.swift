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

    @IBAction func btnRollTapped(_ sender: Any) {
        let diceArray = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]

        imgDice1.image = diceArray[Int.random(in: 0...5)]
        imgDice2.image = diceArray.randomElement()
    }
}

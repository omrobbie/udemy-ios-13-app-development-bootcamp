//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by omrobbie on 10/07/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

class CalculatorLogic {

    var number: Double

    init(number: Double) {
        self.number = number
    }

    func calculate(symbol: String) -> Double? {
        if symbol == "+/-" {
            return number * -1
        } else if symbol == "AC" {
            return 0
        } else if symbol == "%" {
            return number * 0.01
        }

        return nil
    }
}

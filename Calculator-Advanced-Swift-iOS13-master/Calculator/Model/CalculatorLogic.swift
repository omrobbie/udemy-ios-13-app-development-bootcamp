//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by omrobbie on 10/07/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {

    private var number: Double?
    private var intermediateCalculation: (n1: Double, calcMethod: String)?

    mutating func setNumber(_ number: Double) {
        self.number = number
    }

    mutating func calculate(symbol: String) -> Double? {
        guard let number = number else {return nil}

        switch symbol {
        case "+/-": return number * -1
        case "AC": return 0
        case "%": return number * 0.01
        case "=": return performTwoNumCalculation(n2: number)
        default: intermediateCalculation = (n1: number, calcMethod: symbol)
        }

        return nil
    }

    func performTwoNumCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {

            switch operation {
            case "+": return n1 + n2
            case "-": return n1 - n2
            case "×": return n1 * n2
            case "÷": return n1 / n2
            default: fatalError("The operation passed in does not match any of the cases.")
            }
        }

        return nil
    }
}

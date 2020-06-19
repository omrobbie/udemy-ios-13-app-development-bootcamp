//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by omrobbie on 19/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {

    var bmi: Float = 0.0

    mutating func calculatorBMI(height: Float, weight: Float)  {
        bmi = weight / pow(height, 2)
    }

    func getBMIValue() -> String {
        return String(format: "%.1f", bmi)
    }
}

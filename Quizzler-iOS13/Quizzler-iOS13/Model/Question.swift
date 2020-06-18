//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by omrobbie on 18/06/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Question {

    let question: String
    let answer: String
    let choices: [String]

    init(q: String, a: [String], correctAnswer: String) {
        question = q
        answer = correctAnswer
        choices = a
    }
}

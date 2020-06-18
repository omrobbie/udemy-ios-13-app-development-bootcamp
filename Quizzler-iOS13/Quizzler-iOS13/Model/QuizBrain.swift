//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by omrobbie on 18/06/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

struct QuizBrain {

    private let quiz = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]

    private var questionNumber = 0
    private var score = 0

    func getQuestionText() -> String {
        return quiz[questionNumber].question
    }

    func getChoices(choiceNumber: Int) -> String {
        return quiz[questionNumber].choices[choiceNumber-1]
    }

    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }

    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        let actualAnswer = quiz[questionNumber].answer

        if userAnswer == actualAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }

    mutating func nextQuesttion() {
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }

    func getScore() -> Int {
        return score
    }
}

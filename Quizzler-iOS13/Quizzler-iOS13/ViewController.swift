//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var btnTrue: UIButton!
    @IBOutlet weak var btnFalse: UIButton!
    
    let quiz = [
        Question(question: "Four + Two is equal to Six", answer: "True"),
        Question(question: "Five - Three is greater than One", answer: "True"),
        Question(question: "Three + Eight is less than Ten", answer: "False"),
    ]
    
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        lblQuestion.text = quiz[questionNumber].question
    }
    
    @IBAction func btnAnswerTapped(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let actualAnswer = quiz[questionNumber].answer
        
        if userAnswer == actualAnswer {
            print("Right!")
        } else {
            print("Wrong!")
        }
        
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
        
        updateUI()
    }
}

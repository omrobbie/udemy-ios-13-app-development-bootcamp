//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var btnChoice1: UIButton!
    @IBOutlet weak var btnChoice2: UIButton!
    @IBOutlet weak var btnChoice3: UIButton!

    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @objc func updateUI() {
        lblScore.text = "Score: \(quizBrain.getScore())"
        lblQuestion.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()

        btnChoice1.setTitle(quizBrain.getChoices(choiceNumber: 1), for: .normal)
        btnChoice1.backgroundColor = .clear

        btnChoice2.setTitle(quizBrain.getChoices(choiceNumber: 2), for: .normal)
        btnChoice2.backgroundColor = .clear

        btnChoice3.setTitle(quizBrain.getChoices(choiceNumber: 3), for: .normal)
        btnChoice3.backgroundColor = .clear
    }

    @IBAction func btnAnswerTapped(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnswer)

        sender.backgroundColor = userGotItRight ? .systemGreen : .systemRed
        quizBrain.nextQuesttion()

        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
}

//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 5]

    var totalTime = 0
    var secondsPassed = 0

    var timer = Timer()

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            secondsPassed += 1
        } else {
            timer.invalidate()
            progressBar.progress = 1.0
            lblTitle.text = "DONE!"
        }
    }

    @IBAction func btnHardnessTapped(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        lblTitle.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
}

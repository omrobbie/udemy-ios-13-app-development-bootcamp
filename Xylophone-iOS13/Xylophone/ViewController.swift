//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func playSound() {
        let url = Bundle.main.url(forResource: "C", withExtension: ".wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    @IBAction func btnKeyTapped(_ sender: UIButton) {
        playSound()
    }
}

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

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "C", withExtension: ".wav") else {return}

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {return}
            player.play()
        } catch {
            print(error.localizedDescription)
            return
        }
    }

    @IBAction func btnKeyTapped(_ sender: UIButton) {
        playSound()
    }
}

//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!

    let story = [
        "You see a fork in the road."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storyLabel.text = story[0]
        choice1Button.setTitle("Take a left.", for: .normal)
        choice2Button.setTitle("Take a right.", for: .normal)
    }
}

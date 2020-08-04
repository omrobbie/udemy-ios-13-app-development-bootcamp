//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!


    let swifter: Swifter = {
        var dict: NSDictionary?

        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            dict = NSDictionary(contentsOfFile: path)
        }

        guard let data = dict else {
            fatalError("Couldn't found Keys.plist in this project!")
        }

        let consumerKey = data["consumerKey"] as? String ?? ""
        let consumerSecret = data["consumerSecret"] as? String ?? ""
        return Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            print(results)
        }) { (error) in
            print("Error", error.localizedDescription)
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    }
}

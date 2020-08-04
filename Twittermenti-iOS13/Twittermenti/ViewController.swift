//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    let sentimentClassifier = TweetSentimentClassifier()

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

//        var prediction = try! sentimentClassifier.prediction(text: "@Apple is a terrible company!")
//        print(prediction.label)
//        prediction = try! sentimentClassifier.prediction(text: "@Apple is a best company!")
//        print(prediction.label)

        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            if let tweet = results[0]["full_text"].string {
                print(tweet)
            }
        }) { (error) in
            print("Error", error.localizedDescription)
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    }
}

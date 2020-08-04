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

    let tweetCount = 100
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
    }

    private func fetchTweets() {
        sentimentLabel.text = "🤔"

        if let searchText = textField.text {
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                var tweets = [TweetSentimentClassifierInput]()

                for i in 0..<self.tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }

                self.makePrediction(with: tweets)
            }) { (error) in
                print("Error", error.localizedDescription)
            }
        }
    }

    private func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)

            var sentimentScore = 0

            predictions.forEach {
                switch $0.label {
                case "Pos": sentimentScore += 1
                case "Neg": sentimentScore -= 1
                default: break
                }
            }

            updateUI(with: sentimentScore)
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    private func updateUI(with sentimentScore: Int) {
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😁"
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "😟"
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡"
        } else {
            self.sentimentLabel.text = "🤮"
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
        fetchTweets()
    }
}

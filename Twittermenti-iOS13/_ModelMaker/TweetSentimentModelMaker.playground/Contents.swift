import Cocoa
import CreateML

let filePath = "/Users/omrobbie/Documents/_learning/ios-13-app-development-bootcamp/Twittermenti-iOS13/_ModelMaker/"
let fileName = "twitter-sanders-apple3.csv"

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: filePath + fileName))

// Split data into 2 by 0.8 (80%)
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

// Set classifier from data label
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: trainingData, textColumn: "text", labelColumn: "class")

// Check the accuracy of the test
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "omrobbie", shortDescription: "A model trained to classify sentiment on Tweets", license: "open", version: "1.0")

// Save ml model to disk
try sentimentClassifier.write(to: URL(fileURLWithPath: filePath + "TweetSentimentClassifier.mlmodel"))

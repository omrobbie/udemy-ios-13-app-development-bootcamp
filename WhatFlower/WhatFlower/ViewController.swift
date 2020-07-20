//
//  ViewController.swift
//  WhatFlower
//
//  Created by omrobbie on 20/07/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblDescription: UITextView!
    
    private let imagePicker = UIImagePickerController()
    private let BASE_URL = "https://en.wikipedia.org/w/api.php"

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }

    private func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Cannot import model!")
        }

        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let classification = request.results?.first as? VNClassificationObservation else {return}
            let flowerName = classification.identifier.capitalized

            self.navigationItem.title = flowerName
            self.requestInfo(flowerName: flowerName)
        }

        let handler = VNImageRequestHandler(ciImage: image, options: [:])

        do {
            try handler.perform([request])
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        present(imagePicker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Cannot convert to CIImage!")
            }

            detect(image: ciImage)
            imgPhoto.image = userPickedImage
        }
        imagePicker.dismiss(animated: true)
    }
}

// MARK: - Networking
extension ViewController {

    private func requestInfo(flowerName: String) {
        guard let url = URL(string: BASE_URL) else {return}

        let params: [String: Any] = [
            "format": "json",
            "action": "query",
            "prop": "extracts|pageimages",
            "exintro": "",
            "explaintext": "",
            "titles": flowerName,
            "indexpageids": "",
            "redirects": "1",
            "pithumbsize": "500"
        ]

        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            if response.result.isSuccess {
                if let value = response.result.value {
                    let flowerJSON: JSON = JSON(value)
                    let pageId = flowerJSON["query"]["pageids"][0].stringValue
                    let flowerDescription = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
                    let flowerImageUrl = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue

                    DispatchQueue.main.async {
                        if !flowerImageUrl.isEmpty {
                            self.imgPhoto.sd_setImage(with: URL(string: flowerImageUrl))
                        }

                        self.lblDescription.text = flowerDescription.isEmpty ? "Doesn't have a description yet!" : flowerDescription
                    }
                }
            }
        }
    }
}

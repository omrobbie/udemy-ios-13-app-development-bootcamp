//
//  ViewController.swift
//  SeeFood
//
//  Created by omrobbie on 11/07/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var imgCamera: UIImageView!

    let imgPicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
    }

    private func setupImagePicker() {
        imgPicker.delegate = self
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = false
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        present(imgPicker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgCamera.image = userPickedImage

            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage into CIImage.")
            }

            detect(image: ciimage)
        }

        imgPicker.dismiss(animated: true)
    }

    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model failed!")
        }

        let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }

            print(results)
        })

        let handler = VNImageRequestHandler(ciImage: image, options: [:])

        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
}

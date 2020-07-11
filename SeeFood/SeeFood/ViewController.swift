//
//  ViewController.swift
//  SeeFood
//
//  Created by omrobbie on 11/07/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

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

}

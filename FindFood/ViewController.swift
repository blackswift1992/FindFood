//
//  ViewController.swift
//  FindFood
//
//  Created by Олексій Мороз on 22.03.2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let imagePicker = UIImagePickerController()
    
    @IBOutlet private weak var cameraImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            cameraImageView.image = image
        }
        
        imagePicker.dismiss(animated: true)
    }
    
    @IBAction private func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker , animated: true)
    }
    
}


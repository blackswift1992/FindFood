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
    @IBOutlet private weak var resultMessage: UILabel!
    @IBOutlet private weak var alternativeResultMessage: UILabel!
    
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
            
            guard let ciimage = CIImage(image: image) else {
                fatalError("Could not convert into CIImage")
            }
            
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true)
    }
    
    private func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: MLModel(contentsOf: Inceptionv3.urlOfModelInThisBundle)) else {
            fatalError("Loading CoreML Model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            self?.resultMessage.text = "\(Int(Double(results[0].confidence) * 100))%: \(results[0].identifier)"
            self?.alternativeResultMessage.text = "\(Int(Double(results[1].confidence) * 100))%: \(results[1].identifier)"
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction private func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker , animated: true)
    }
}


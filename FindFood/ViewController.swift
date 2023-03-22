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

    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }
    
}


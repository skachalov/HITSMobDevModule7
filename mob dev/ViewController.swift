//
//  ViewController.swift
//  mob dev
//
//  Created by Пользователь on 30.04.2021.
//  Copyright © 2021 Пользователь. All rights reserved.
//

//

import UIKit
import SwiftImage

var picture = UIImage()
var mainPicture = UIImage()

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textToLoad: UILabel!
    @IBOutlet weak var scaling: UITextField!
    @IBOutlet weak var angle: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(load(_ :)))
        img.addGestureRecognizer(tap)
        img.isUserInteractionEnabled = true
    }

    @objc func load(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Image", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "Photo library", style: .default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionPhoto)
        alert.addAction(actionCamera)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            mainPicture = pickedImage
//            let tmp = Image<RGBA<UInt8>>(uiImage: pickedImage)
//            let height = tmp.height
//            let width = tmp.width
//            if (height >= 512 || width >= 512) {
//                let size = 512
//                var newHeight: Int = size, newWidth: Int = size
//                if height >= width {
//                        newWidth = Int((width*size)/height)
//                } else {
//                    newHeight = Int((height*size)/width)
//                }
//                picture = tmp.resizedTo(width: newWidth, height: newHeight, interpolatedBy: .nearestNeighbor).uiImage
//            } else {
//                picture = pickedImage
//            }
            
            let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "test") as! testViewController
            self.navigationController?.pushViewController(next, animated: true)
        }
        //dismiss(animated: false, completion: nil)
    }
}



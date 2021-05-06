//
//  ViewController.swift
//  mob dev
//
//  Created by Пользователь on 30.04.2021.
//  Copyright © 2021 Пользователь. All rights reserved.
//

//

import UIKit

var originalImage = UIImage()

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textToLoad: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(load(_ :)))
        img.addGestureRecognizer(tap)
        img.isUserInteractionEnabled = true
    }

    @objc func load(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Изображение", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "Фотогаллерея", style: .default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "Камера", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(actionPhoto)
        alert.addAction(actionCamera)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func chooseRotation(_ sender: UISegmentedControl) {
        
        let image:UIImage = originalImage
        
        let height = Int((image.size.height))
        let width = Int((image.size.width))

        let bitsPerComponent = Int(8)
        let bytesPerRowHorizontally = 4 * width
        let bytesPerRowVertically = 4 * height

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let rawDataHorizontally = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
        let rawDataVertically = UnsafeMutablePointer<UInt32>.allocate(capacity: (height * height))

        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        let CGPointZero = CGPoint(x: 0, y: 0)
        let rect = CGRect(origin: CGPointZero, size: (image.size))

        let imageContext = CGContext(data: rawDataHorizontally, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRowHorizontally, space: colorSpace, bitmapInfo: bitmapInfo)

        imageContext?.draw(image.cgImage!, in: rect)
        
        let pixelsOriginal = UnsafeMutableBufferPointer<UInt32>(start: rawDataHorizontally, count: width * height)
        if sender.selectedSegmentIndex == 0 {
            img.image = originalImage
        }
        if sender.selectedSegmentIndex == 1 {

            let newPixels = UnsafeMutableBufferPointer<UInt32>(start: rawDataVertically, count: width * height)
            var counter = 0
            for  x in 0..<width {
                for  y in 0..<height{
                    newPixels[counter] = pixelsOriginal[(height-1-y)*width + x]
                    counter += 1
                }
            }
            let outContext = CGContext(data: newPixels.baseAddress, width: height, height: width, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRowVertically,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
            let outImage = UIImage(cgImage: outContext!.makeImage()!)
            img.image = outImage
        }
        if sender.selectedSegmentIndex == 2 {
            let newPixels = UnsafeMutableBufferPointer<UInt32>(start: rawDataVertically, count: height * width)
            var counter = 0
            for y in 0..<height {
                for x in 0..<width {
                    newPixels[counter] = pixelsOriginal[(height-1-y)*width + (width-1-x)]
                    counter += 1
                }
            }
            let outContext = CGContext(data: newPixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRowHorizontally,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
            let outImage = UIImage(cgImage: outContext!.makeImage()!)
            img.image = outImage
        }
        if sender.selectedSegmentIndex == 3 {
            let newPixels = UnsafeMutableBufferPointer<UInt32>(start: rawDataVertically, count: width * height)
            var counter = 0
            for  x in 0..<width {
                for  y in 0..<height{
                    newPixels[counter] = pixelsOriginal[(width-1-x) + width*y]
                    counter += 1
                }
            }
            let outContext = CGContext(data: newPixels.baseAddress, width: height, height: width, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRowVertically,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
            let outImage = UIImage(cgImage: outContext!.makeImage()!)
            img.image = outImage
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image = pickedImage
            originalImage = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}



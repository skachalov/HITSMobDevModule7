//
//  saverViewController.swift
//  mob dev
//
//  Created by spoonty on 5/21/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class saverViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        for i in 0..<operations.count {
            if operations[i] == "Rotation" {
                mainPicture = firstAlgo(img: mainPicture)
            }
            if operations[i] == "RotationBonus" {
                mainPicture = firstAlgoBonus(img: mainPicture, angle: action[i])
            }
            if operations[i] == "Negative" {
                var massiv = getMassivOfPixels(img: mainPicture)
                massiv = mob_dev.Negativ(pixels: massiv, img: mainPicture)
                mainPicture = ShowImgFromMassiv(pixels: massiv, img: mainPicture)
            }
            if operations[i] == "Sepia" {
                var massiv = getMassivOfPixels(img: mainPicture)
                massiv = mob_dev.Sepia(pixels: massiv, img: mainPicture)
                mainPicture = ShowImgFromMassiv(pixels: massiv, img: mainPicture)
            }
            if operations[i] == "RedBlueSwap" {
                var massiv = getMassivOfPixels(img: mainPicture)
                massiv = mob_dev.RedBlueSwap(pixels: massiv, img: mainPicture)
                mainPicture = ShowImgFromMassiv(pixels: massiv, img: mainPicture)
            }
            if operations[i] == "BlackLivesMatter" {
                var massiv = getMassivOfPixels(img: mainPicture)
                massiv = BlackLiveMAtters(pixels: massiv, img: mainPicture)
                mainPicture = ShowImgFromMassiv(pixels: massiv, img: mainPicture)
            }
            if operations[i] == "AbsoluteRed" {
                var massiv = getMassivOfPixels(img: mainPicture)
                massiv = mob_dev.AbsoluteRed(pixels: massiv, img: mainPicture)
                mainPicture = ShowImgFromMassiv(pixels: massiv, img: mainPicture)
            }
        }
        if face == true {
            let tmp = OCVWrapper.classifyImage(mainPicture)
              if ( tmp != nil){
                mainPicture = tmp!
              }
        }
        if resizeCoeff != 1.0 {
            mainPicture = thirdAlgo(img: mainPicture, k: resizeCoeff)
        }
        print(resizeCoeff)
        img.image = mainPicture
        UIImageWriteToSavedPhotosAlbum(mainPicture, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
            } else {
                let ac = UIAlertController(title: "Saved", message: "Your image has been saved to your photos", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }

    
}

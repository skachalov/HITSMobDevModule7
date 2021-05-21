//
//  tabView2ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/16/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

class tabView2ViewController: UIViewController {

    
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }

    
    @IBAction func Negativ(_ sender: Any) {
        var massiv = getMassivOfPixels(img: img.image!)
        massiv = mob_dev.Negativ(pixels: massiv, img: img.image!)
        img.image = ShowImgFromMassiv(pixels: massiv, img: img.image!)
        picture = img.image!
        operations.append("Negative")
        action.append(0.0)
      
    }
    
    @IBAction func Sepia(_ sender: Any) {
        var massiv = getMassivOfPixels(img: img.image!)
        massiv = mob_dev.Sepia(pixels: massiv, img: img.image!)
        img.image = ShowImgFromMassiv(pixels: massiv, img: img.image!)
        picture = img.image!
        operations.append("Sepia")
        action.append(0.0)
    }
    
    
    @IBAction func RedBlueSwap(_ sender: Any) {
        var massiv = getMassivOfPixels(img: img.image!)
        massiv = mob_dev.RedBlueSwap(pixels: massiv, img: img.image!)
        img.image = ShowImgFromMassiv(pixels: massiv, img: img.image!)
        picture = img.image!
        operations.append("RedBlueSwap")
        action.append(0.0)
    }
    
    @IBAction func BlackLivesMatter(_ sender: Any) {
        var massiv = getMassivOfPixels(img: img.image!)
        massiv = BlackLiveMAtters(pixels: massiv, img: img.image!)
        img.image = ShowImgFromMassiv(pixels: massiv, img: img.image!)
        picture = img.image!
        operations.append("BlackLivesMatter")
        action.append(0.0)
    }
    
    @IBAction func AbsoluteRed(_ sender: Any) {
        var massiv = getMassivOfPixels(img: img.image!)
        massiv = mob_dev.AbsoluteRed(pixels: massiv, img: img.image!)
        img.image = ShowImgFromMassiv(pixels: massiv, img: img.image!)
        picture = img.image!
        operations.append("AbsoluteRed")
        action.append(0.0)
    }
}

//
//  tabView4ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/16/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

class tabView4ViewController: UIViewController {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 10

    }
    
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }
    
    @IBAction func MakeMask(_ sender: Any) {
        img.image = UnsharpMask(koef: effectForMask, radiusDan: radiusForMask, img: img.image!).uiImage
        picture = img.image!
        operations.append("Mask")
        action.append(Double(effectForMask))
        operations.append("Mask")
        action.append(Double(radiusForMask))
    }
    
    
    var radiusForMask: Int = 0
    var effectForMask: Int = 0
    
    
    @IBAction func Effect(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        effectForMask = currentValue
    }
    @IBAction func Radius(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        radiusForMask = currentValue
    }
}

//
//  tabView6ViewController.swift
//  mob dev
//
//  Created by Тимофей Веретнов on 21.05.2021.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

class tabView6ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }

    var koef : Int = 0
    var sizeOfD : Int = 0
    @IBAction func Size(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        sizeOfD = currentValue
    }
    
    @IBAction func Koef(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        koef = currentValue
    }
    
    @IBAction func qw(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: img)
        let radDan = koef
        let sizeOfDraw = sizeOfD
        img.image = GaussianBlur.createBlurredImage(radius: radDan, image: img.image!,gottenBeginX: 10, gottenBeginY: 10 ,gottenX: 30, gottenY: 30 ).uiImage
        print(point.x)
        print(point.y)
    }
    
    
    
    
    
}

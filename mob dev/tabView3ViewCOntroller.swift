//
//  tabView3ViewCOntroller.swift
//  mob dev
//
//  Created by spoonty on 5/16/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

class tabView3ViewCOntroller: UIViewController {
    
    
    @IBOutlet weak var coeff: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var setVar: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVar.value = 1.0
        button.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        img.image = picture
    }

    @IBAction func set(_ sender: UIStepper) {
        coeff.text = String(NSString(format: "%.2f", setVar.value))
    }
    
    @IBAction func start(_ sender: Any) {
        let k: Double = Double(coeff.text!)!

        img.image = thirdAlgo(img: img.image!, k: k)
        picture = img.image!
        isThird = true
        arrayOfSize.append(k)
    }
    

}

//
//  tabView3ViewCOntroller.swift
//  mob dev
//
//  Created by spoonty on 5/16/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

var isThird = false
var arrayOfSize = [Double]()

class tabView3ViewCOntroller: UIViewController {
    
    
    @IBOutlet weak var coeff: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        img.image = picture
    }

    @IBAction func set(_ sender: UIStepper) {
        coeff.text = String(sender.value)
    }
    
    @IBAction func start(_ sender: Any) {
        let k: Double = Double(coeff.text!)!

        img.image = thirdAlgo(img: img.image!, k: k)
        picture = img.image!
        isThird = true
        arrayOfSize.append(k)
    }
    

}

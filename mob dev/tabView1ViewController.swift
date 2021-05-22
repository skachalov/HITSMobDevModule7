//
//  tabView1ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/14/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

var tmpImage = UIImage()

class tabView1ViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    @IBOutlet weak var sliderVal: UISlider!
    @IBOutlet weak var setAngleVal: UITextField!
    var imageIS: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderVal.value = 0
        setAngleVal.text = "0"
    }
    override func viewWillDisappear(_ animated: Bool) {
        if (setAngleVal.text != "0") {
            operations.append("RotationBonus")
            action.append(Double(setAngleVal.text!)!)
        }
    }
    
    //  повороты были решены вместе с Степаном Потаповым
    @IBAction func sliderForSetAngle(_ sender: UISlider) {
        setAngleVal.text = String(round(sender.value))
        
        let outImage = firstAlgoBonus(img: tmpImage, angle: Double(setAngleVal.text!)!)
        
        img.image = outImage
        picture = outImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dismiss(animated: false, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        if firstAppear == true {
            loading()
            waiting.stopAnimating()
            waiting.hidesWhenStopped = true
            firstAppear = false
        } else {
            img.image = picture
        }
        tmpImage = picture
    }

    
    func loading() {
        img.image = picture
        let tmp = Image<RGBA<UInt8>>(uiImage: mainPicture)
        let height = tmp.height
        let width = tmp.width
        if (height >= 512 || width >= 512) {
            let size = 512
            var newHeight: Int = size, newWidth: Int = size
            if height >= width {
                    newWidth = Int((width*size)/height)
            } else {
                newHeight = Int((height*size)/width)
            }
            picture = tmp.resizedTo(width: newWidth, height: newHeight, interpolatedBy: .nearestNeighbor).uiImage
            isChanged = true
        } else {
            picture = mainPicture
            isChanged = false
        }
        img.image = picture
    }
    
    @IBAction func rotate(_ sender: Any) {
        setAngleVal.text = "0"
        sliderVal.value = 0
 
        img.image = firstAlgo(img: tmpImage)
        picture = img.image!
        tmpImage = picture
        
        operations.append("Rotation")
        action.append(0.0)
        
    }
}

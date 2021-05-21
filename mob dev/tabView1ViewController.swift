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
    
    //  повороты были решены вместе с Степаном Потаповым
    @IBAction func sliderForSetAngle(_ sender: UISlider) {
        setAngleVal.text = String(round(sender.value))
        
        let angleVal = Double(setAngleVal.text!)! * .pi / 180
        let image = Image<RGBA<UInt8>>(uiImage: tmpImage)
        let height = image.height
        let width = image.width
        
        var newImage = Image<RGBA<UInt8>>(width: width, height: height, pixel: .black)
        
        let centerX = Int(width/2)
        let centerY = Int(height/2)
        
        for x in 0..<width {
            for y in 0..<height {
                let xp1 = Int( Double(x-centerX) - Double(y-centerY) * tan(angleVal/2) + Double(centerX)  )
                let yp1 = Int( Double(y-centerY) + Double(centerY)  )
                
                let xp2 = Int( Double(xp1-centerX) + Double(centerX) )
                let yp2 = Int( Double(xp1-centerX) * sin(angleVal) + Double(yp1-centerY) + Double(centerY) )
                
                let xp3 = Int( Double(xp2-centerX) - Double(yp2-centerY) * tan(angleVal/2) + Double(centerX) )
                let yp3 = Int( Double(yp2-centerY) + Double(centerY) )
                
                if 0  <= xp3 && xp3 < width && 0 <= yp3 && yp3 < height {
                        newImage[xp3, yp3] = image[x, y]
                }
            }
        }
        
        let outImage = newImage.uiImage
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
        } else {
            picture = mainPicture
        }
        img.image = picture
    }
    
    @IBAction func rotate(_ sender: Any) {
        setAngleVal.text = "0"
        sliderVal.value = 0
 
        img.image = firstAlgo(img: tmpImage)
        picture = img.image!
        tmpImage = picture
        
    }
}

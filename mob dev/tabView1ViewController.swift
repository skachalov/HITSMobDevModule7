//
//  tabView1ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/14/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

class tabView1ViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    //var picture: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = picture
    }
    
    @IBAction func rotate(_ sender: Any) {
        let image = Image<RGBA<UInt8>>(uiImage: img.image!)
        let height = image.height
        let width = image.width
        
        var newImage = Image<RGBA<UInt8>>(width: height, height: width, pixel: .black)

        var x = 0
        var y = 0

        for i in 0..<width {
            for j in (0..<height).reversed() {
                newImage[x, y] = image[i,j]
                x += 1
            }
            x = 0
            y += 1
        }
        
        img.image = newImage.uiImage
        picture = newImage.uiImage
    }
}

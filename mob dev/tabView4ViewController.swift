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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        img.image = picture
    }
    
    func UnsharpMask(){
        let blurImage = GaussianBlur.createBlurredImage(radius: 5, image: img.image!)
        let image = img.image!
        let originImage = Image<RGBA<UInt8>>(uiImage: image)
        var unSharpImage = Image<RGBA<UInt8>>(uiImage: image)
        let width = originImage.width
        let height = originImage.height
        for x in 0...height{
            for y in 0...width{
                unSharpImage[x,y].red = originImage[x,y].red - blurImage[x,y].red
                unSharpImage[x,y].green = originImage[x,y].green - blurImage[x,y].green
                unSharpImage[x,y].blue = originImage[x,y].blue - blurImage[x,y].blue
                if (unSharpImage[x,y].red < 0){
                    unSharpImage[x,y].red = 0
                }
                if (unSharpImage[x,y].green < 0){
                    unSharpImage[x,y].green = 0
                    
                }
                if (unSharpImage[x,y].blue < 0)
                {unSharpImage[x,y].blue = 0
                }
            }
        }
    }
}

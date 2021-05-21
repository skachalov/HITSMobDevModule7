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
    
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }
    
    func UnsharpMask(koef: Int, radiusDan: Int) -> Image<RGBA<UInt8>>{
        let blurImage = GaussianBlur.createBlurredImage(radius: radiusDan, image: img.image!)
        let image = img.image!
        var originImage = Image<RGBA<UInt8>>(uiImage: image)
        var unSharpImage = Image<RGBA<UInt8>>(uiImage: image)
        let width = originImage.width
        let height = originImage.height
        for x in 0..<width{
            for y in 0..<height{
                
               
                if (Int(originImage[x,y].red) - Int(blurImage[x,y].red) <= 0){
                    unSharpImage[x,y].red = 0
                }
                else{
                    unSharpImage[x,y].red = originImage[x,y].red - blurImage[x,y].red
                }
                
                if(Int(unSharpImage[x,y].red) * koef + Int(originImage[x,y].red) > 255){
                    originImage[x,y].red = 255
                }
                else{
                    originImage[x,y].red  += UInt8(Int(unSharpImage[x,y].red) * koef)
                }
                
                
                
                if (Int(originImage[x,y].green) - Int(blurImage[x,y].green) <= 0){
                    unSharpImage[x,y].green = 0
                }
                else{
                    unSharpImage[x,y].green = originImage[x,y].green - blurImage[x,y].green
                }
                if(Int(unSharpImage[x,y].green) * koef + Int(originImage[x,y].green) > 255){
                    originImage[x,y].green = 255
                }
                else{
                    originImage[x,y].green  += UInt8(Int(unSharpImage[x,y].green) * koef)
                }
                
                
                
                
                
                if (Int(originImage[x,y].blue) - Int(blurImage[x,y].blue) <= 0){
                    unSharpImage[x,y].blue = 0
                }
                else{
                    unSharpImage[x,y].blue = originImage[x,y].blue - blurImage[x,y].blue
                }
                if(Int(unSharpImage[x,y].blue) * koef + Int(originImage[x,y].green) > 255){
                    originImage[x,y].blue = 255
                }
                else{
                    originImage[x,y].blue  += UInt8(Int(unSharpImage[x,y].blue) * koef)
                }
                
                
            }
        }
        return unSharpImage
    }
    
    @IBAction func MakeMask(_ sender: Any) {
        img.image = UnsharpMask(koef: effectForMask, radiusDan: radiusForMask).uiImage
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

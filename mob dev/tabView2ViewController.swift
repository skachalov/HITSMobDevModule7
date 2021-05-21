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

    func getMassivOfPixels() -> UnsafeMutableBufferPointer<UInt32> {
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)

        let bitsPerComponent = Int(8)
        let bytesPerRow = 4 * width
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rawData = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        let CGPointZero = CGPoint(x: 0, y: 0)
        let rect = CGRect(origin: CGPointZero, size: (image?.size)!)



        let imageContext = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)

        imageContext?.draw(image!.cgImage!, in: rect)

        let pixels = UnsafeMutableBufferPointer<UInt32>(start: rawData, count: width * height)
        return pixels
    }
    
    func Negativ(pixels: UnsafeMutableBufferPointer<UInt32> ) -> UnsafeMutableBufferPointer<UInt32>{
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)
        for  y in 0..<height {
            for  x in 0..<width{
                
                var p = pixels[x+y*width]
                var tmp =  RGBAPixel(rawVal: p)

                tmp.red = 255 - tmp.red
                tmp.green = 255 - tmp.red
                tmp.blue = 255 - tmp.blue
                p = RGBAPixel(rawVal: tmp.raw).raw
                pixels[x+y*width] = p
                
            }
        }
        return pixels
    }
    func AbsoluteRed(pixels: UnsafeMutableBufferPointer<UInt32> ) -> UnsafeMutableBufferPointer<UInt32>{
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)
        for  y in 0..<height {
            for  x in 0..<width{
                
                var p = pixels[x+y*width]
                var tmp =  RGBAPixel(rawVal: p)
                if (tmp.red > 244) {
                    tmp.red = 255
                }
                else{
                    tmp.red += 10
                }
                p = RGBAPixel(rawVal: tmp.raw).raw
                pixels[x+y*width] = p
               
            }
        }
        return pixels
    }
    func Sepia(pixels: UnsafeMutableBufferPointer<UInt32> ) -> UnsafeMutableBufferPointer<UInt32>{
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)
        
        for  y in 0..<height {
            for  x in 0..<width{
                
                var p = pixels[x+y*width]
                var tmp =  RGBAPixel(rawVal: p)
                let total = (tmp.blue / 3 + tmp.green / 3 + tmp.red / 3)
                
                tmp.blue = total
                
                if (Int(total) + 40 > 255){
                    tmp.red  = 255
                }
                else {
                    tmp.red = total + 40
                }
                
                if (Int(total) + 20 > 255){
                    tmp.green  = 255
                }
                else {
                    tmp.green = total + 20
                }
                
                p = RGBAPixel(rawVal: tmp.raw).raw
                pixels[x+y*width] = p
                
            }
        }
        return pixels
    }
    func BlackLiveMAtters(pixels: UnsafeMutableBufferPointer<UInt32> ) -> UnsafeMutableBufferPointer<UInt32>{
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)
        
        for  y in 0..<height {
            for  x in 0..<width{
                
                var p = pixels[x+y*width]
                var tmp =  RGBAPixel(rawVal: p)
                var total : UInt32  = UInt32(tmp.red) + UInt32(tmp.green) + UInt32(tmp.blue)
                if total > 255 {
                    p = RGBAPixel(rawVal: 0).raw
                    pixels[x+y*width] = p
                }
                else {
                    p = RGBAPixel(rawVal: 0xFFFFFFFF).raw
                    pixels[x+y*width] = p
                }
                
            }
        }
        return pixels
    }
    func RedBlueSwap(pixels: UnsafeMutableBufferPointer<UInt32> ) -> UnsafeMutableBufferPointer<UInt32>{
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)
        
        for  y in 0..<height {
            for  x in 0..<width{
                
                var p = pixels[x+y*width]
                var tmp =  RGBAPixel(rawVal: p)
                let tmpsave = tmp.blue
                tmp.blue = tmp.red
                tmp.red = tmpsave
                
                p = RGBAPixel(rawVal: tmp.raw).raw
                pixels[x+y*width] = p
                
            }
        }
        return pixels
    }
    
    
    func ShowImgFromMassiv(pixels: UnsafeMutableBufferPointer<UInt32> ) -> UIImage{
        let image = img.image

        let height = Int((image?.size.height)!)

        let width = Int((image?.size.width)!)

        let bitsPerComponent = Int(8)
        let bytesPerRow = 4 * width
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rawData = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        let CGPointZero = CGPoint(x: 0, y: 0)
        let rect = CGRect(origin: CGPointZero, size: (image?.size)!)



        let imageContext = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)

        imageContext?.draw(image!.cgImage!, in: rect)
        
        let outContext = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRow,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)

        let  outImage = UIImage(cgImage: outContext!.makeImage()!)
        return outImage
    }
    
    @IBAction func Negativ(_ sender: Any) {
        var massiv = getMassivOfPixels()
        massiv = Negativ(pixels: massiv)
        img.image = ShowImgFromMassiv(pixels: massiv)
        picture = img.image!
      
    }
    
    @IBAction func Sepia(_ sender: Any) {
        var massiv = getMassivOfPixels()
        massiv = Sepia(pixels: massiv)
        img.image = ShowImgFromMassiv(pixels: massiv)
        picture = img.image!
    }
    
    
    @IBAction func RedBlueSwap(_ sender: Any) {
        var massiv = getMassivOfPixels()
        massiv = RedBlueSwap(pixels: massiv)
        img.image = ShowImgFromMassiv(pixels: massiv)
        picture = img.image!
    }
    
    @IBAction func BlackLivesMatter(_ sender: Any) {
        var massiv = getMassivOfPixels()
        massiv = BlackLiveMAtters(pixels: massiv)
        img.image = ShowImgFromMassiv(pixels: massiv)
        picture = img.image!
    }
    
    @IBAction func AbsoluteRed(_ sender: Any) {
        var massiv = getMassivOfPixels()
        massiv = AbsoluteRed(pixels: massiv)
        img.image = ShowImgFromMassiv(pixels: massiv)
        picture = img.image!
    }
}

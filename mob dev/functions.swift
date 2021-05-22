//
//  functions.swift
//  mob dev
//
//  Created by spoonty on 5/19/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import Foundation
import SwiftImage

// ПОВОРОТЫ ИЗОБРАЖЕНИЯ

func firstAlgo(img: UIImage) -> UIImage {
    let image = Image<RGBA<UInt8>>(uiImage: img)
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
    
    let outImage = newImage.uiImage
    
    return outImage
}

func firstAlgoBonus(img: UIImage, angle: Double) -> UIImage {
    
    let angleVal = angle * .pi / 180
    let image = Image<RGBA<UInt8>>(uiImage: img)
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
    
    return newImage.uiImage
}



// ФИЛЬТРЫ


func getMassivOfPixels(img: UIImage) -> UnsafeMutableBufferPointer<UInt32> {
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))

    let bitsPerComponent = Int(8)
    let bytesPerRow = 4 * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let rawData = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
    let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
    let CGPointZero = CGPoint(x: 0, y: 0)
    let rect = CGRect(origin: CGPointZero, size: (image.size))



    let imageContext = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)

    imageContext?.draw(image.cgImage!, in: rect)

    let pixels = UnsafeMutableBufferPointer<UInt32>(start: rawData, count: width * height)
    return pixels
}

func Negativ(pixels: UnsafeMutableBufferPointer<UInt32>, img: UIImage) -> UnsafeMutableBufferPointer<UInt32>{
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))
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
func AbsoluteRed(pixels: UnsafeMutableBufferPointer<UInt32>, img: UIImage) -> UnsafeMutableBufferPointer<UInt32>{
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))
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
func Sepia(pixels: UnsafeMutableBufferPointer<UInt32>, img: UIImage) -> UnsafeMutableBufferPointer<UInt32>{
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))
    
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
func BlackLiveMAtters(pixels: UnsafeMutableBufferPointer<UInt32>, img: UIImage) -> UnsafeMutableBufferPointer<UInt32>{
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))
    
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
func RedBlueSwap(pixels: UnsafeMutableBufferPointer<UInt32>, img: UIImage) -> UnsafeMutableBufferPointer<UInt32>{
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))
    
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


func ShowImgFromMassiv(pixels: UnsafeMutableBufferPointer<UInt32>, img: UIImage) -> UIImage{
    let image = img

    let height = Int((image.size.height))

    let width = Int((image.size.width))

    let bitsPerComponent = Int(8)
    let bytesPerRow = 4 * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let rawData = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
    let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
    let CGPointZero = CGPoint(x: 0, y: 0)
    let rect = CGRect(origin: CGPointZero, size: (image.size))



    let imageContext = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)

    imageContext?.draw(image.cgImage!, in: rect)
    
    let outContext = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRow,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)

    let  outImage = UIImage(cgImage: outContext!.makeImage()!)
    return outImage
}




// МАСШТАБИРОВАНИЕ


func buildMipmap(height: Int, width: Int, k: Double) -> (width: Int, height: Int) {
    var nearest: Int = 1

    while (nearest*2 <= Int(Double(width)*k)) {
        nearest *= 2
    }

    let widthS = nearest
    let heightS = (height*widthS)/width
    let size = (width: widthS, height: heightS)

    return size
}

func bilinearInterpolation(image: Image<RGBA<UInt8>>, height: Int, width: Int, heightR: Int, widthR: Int) -> Image<RGBA<UInt8>> {
    var newImage = Image<RGBA<UInt8>>(width: widthR, height: heightR, pixel: .black)

    let xRatio = Double(width-1)/Double(widthR)
    let yRatio = Double(height-1)/Double(heightR)

    for i in 0..<heightR {
        for j in 0..<widthR {
            let x = Int(xRatio * Double(j))
            let y = Int(yRatio * Double(i))
            let xDist: Double = (xRatio*Double(j)) - Double(x)
            let yDist: Double = (yRatio*Double(i)) - Double(y)

            let UL: RGBA<UInt8> = image[x, y]
            let UR: RGBA<UInt8> = image[x+1, y]
            let LL: RGBA<UInt8> = image[x, y+1]
            let LR: RGBA<UInt8> = image[x+1, y+1]

            newImage[j, i].red = UInt8(Double(UL.red)*(1-xDist)*(1-yDist) + Double(UR.red)*xDist*(1-yDist) + Double(LL.red)*(1-xDist)*yDist + Double(LR.red)*xDist*yDist)
            newImage[j, i].green = UInt8(Double(UL.green)*(1-xDist)*(1-yDist) + Double(UR.green)*xDist*(1-yDist) + Double(LL.green)*(1-xDist)*yDist + Double(LR.green)*xDist*yDist)
            newImage[j, i].blue = UInt8(Double(UL.blue)*(1-xDist)*(1-yDist) + Double(UR.blue)*xDist*(1-yDist) + Double(LL.blue)*(1-xDist)*yDist + Double(LR.blue)*xDist*yDist)
        }
    }

    return newImage
}

func trilinearInterpolation(image: Image<RGBA<UInt8>>, imageS: Image<RGBA<UInt8>>, height: Int, width: Int, heightS: Int, widthS: Int, heightR: Int, widthR: Int) -> Image<RGBA<UInt8>> {
    var newImage = Image<RGBA<UInt8>>(width: widthR, height: heightR, pixel: .black)

    let xRatio = Double(width-1)/Double(widthR)
    let yRatio = Double(height-1)/Double(heightR)
    let xRatioS = Double(widthS-1)/Double(widthR)
    let yRatioS = Double(heightS-1)/Double(heightR)

    let dist = Double(width-widthR)/Double(width-widthS)

    for i in 0..<heightR {
        for j in 0..<widthR {
            let x = Int(xRatio * Double(j))
            let y = Int(yRatio * Double(i))
            let xDist = (xRatio*Double(j)) - Double(x)
            let yDist = (yRatio*Double(i)) - Double(y)

            let UL: RGBA<UInt8> = image[x, y]
            let UR: RGBA<UInt8> = image[x+1, y]
            let LL: RGBA<UInt8> = image[x, y+1]
            let LR: RGBA<UInt8> = image[x+1, y+1]

            let xS = Int(xRatioS * Double(j))
            let yS = Int(yRatioS * Double(i))
            let xDistS = (xRatioS*Double(j)) - Double(xS)
            let yDistS = (yRatioS*Double(i)) - Double(yS)

            let ULS: RGBA<UInt8> = imageS[xS, yS]
            let URS: RGBA<UInt8> = imageS[xS+1, yS]
            let LLS: RGBA<UInt8> = imageS[xS, yS+1]
            let LRS: RGBA<UInt8> = imageS[xS+1, yS+1]

            newImage[j, i].red = UInt8(Double(UL.red)*(1-xDist)*(1-yDist)*(1-dist) + Double(UR.red)*xDist*(1-yDist)*(1-dist) + Double(LL.red)*yDist*(1-xDist)*(1-dist) + Double(LR.red)*xDist*yDist*(1-dist) + Double(ULS.red)*(1-xDistS)*(1-yDistS)*dist + Double(URS.red)*xDistS*(1-yDistS)*dist + Double(LLS.red)*(1-xDistS)*yDistS*dist + Double(LRS.red)*xDistS*yDistS*dist)
            newImage[j, i].green = UInt8(Double(UL.green)*(1-xDist)*(1-yDist)*(1-dist) + Double(UR.green)*xDist*(1-yDist)*(1-dist) + Double(LL.green)*yDist*(1-xDist)*(1-dist) + Double(LR.green)*xDist*yDist*(1-dist) + Double(ULS.green)*(1-xDistS)*(1-yDistS)*dist + Double(URS.green)*xDistS*(1-yDistS)*dist + Double(LLS.green)*(1-xDistS)*yDistS*dist + Double(LRS.green)*xDistS*yDistS*dist)
            newImage[j, i].blue = UInt8(Double(UL.blue)*(1-xDist)*(1-yDist)*(1-dist) + Double(UR.blue)*xDist*(1-yDist)*(1-dist) + Double(LL.blue)*yDist*(1-xDist)*(1-dist) + Double(LR.blue)*xDist*yDist*(1-dist) + Double(ULS.blue)*(1-xDistS)*(1-yDistS)*dist + Double(URS.blue)*xDistS*(1-yDistS)*dist + Double(LLS.blue)*(1-xDistS)*yDistS*dist + Double(LRS.blue)*xDistS*yDistS*dist)

        }
    }

   return newImage
}

func thirdAlgo(img: UIImage, k: Double) -> UIImage {
    let image = Image<RGBA<UInt8>>(uiImage: img)
    let height: Int = image.height
    let width: Int = image.width

    let heightR: Int = Int(Double(height)*k)
    let widthR: Int = Int(Double(width)*k)

    if k > 1.0 {
        let img1: UIImage = bilinearInterpolation(image: image, height: height, width: width, heightR: heightR, widthR: widthR).uiImage
        return img1
    } else if k < 1.0 {
        let size = buildMipmap(height: height, width: width, k: k)
        let heightS = size.height
        let widthS = size.width
        let imageS = bilinearInterpolation(image: image, height: height, width: width, heightR: heightS, widthR: widthS)
        let img1: UIImage = trilinearInterpolation(image: image, imageS: imageS, height: height, width: width, heightS: heightS, widthS: widthS, heightR: heightR, widthR: widthR).uiImage
        return img1
    }
    
    return img
}





// МАСКИРОВАНИЕ


func UnsharpMask(koef: Int, radiusDan: Int, img: UIImage) -> Image<RGBA<UInt8>>{
    let blurImage = GaussianBlur.createBlurredImage(radius: radiusDan, image: img,gottenBeginX: radiusDan, gottenBeginY: radiusDan ,gottenX: Image<RGBA<UInt8>>(uiImage: img).width, gottenY: Image<RGBA<UInt8>>(uiImage: img).height)
    let image = img
    var originImage = Image<RGBA<UInt8>>(uiImage: image)
    
    let width = originImage.width
    let height = originImage.height
    for x in 0..<width{
        for y in 0..<height{
            
            var tmpred : Int = Int(originImage[x,y].red) - Int(blurImage[x,y].red)
            var tmpgreen: Int = Int(originImage[x,y].red) - Int(blurImage[x,y].red)
            var tmpblue : Int = Int(originImage[x,y].red) - Int(blurImage[x,y].red)
            
            
            if(tmpred * koef + Int(originImage[x,y].red) > 255){
                originImage[x,y].red = 255
            }
            else {
                if (tmpred * koef + Int(originImage[x,y].red) < 0){
                    originImage[x,y].red  = 0
                }
                else{
                    originImage[x,y].red = UInt8(tmpred * koef + Int(originImage[x,y].red))
                }
            }
            
            
            
            if(tmpgreen * koef + Int(originImage[x,y].green) > 255){
                originImage[x,y].green = 255
            }
            else {
                if (tmpgreen * koef + Int(originImage[x,y].green) < 0){
                    originImage[x,y].green  = 0
                }
                else{
                    originImage[x,y].green = UInt8(tmpgreen * koef + Int(originImage[x,y].green))
                }
            }
            
            if(tmpblue * koef + Int(originImage[x,y].blue) > 255){
                originImage[x,y].blue = 255
            }
            else {
                if (tmpblue * koef + Int(originImage[x,y].blue) < 0){
                    originImage[x,y].blue  = 0
                }
                else{
                    originImage[x,y].blue = UInt8(tmpblue * koef + Int(originImage[x,y].blue))
                }
            }
        }
    }
    return originImage
}

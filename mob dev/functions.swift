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
    picture = newImage.uiImage
    
    return outImage
}

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



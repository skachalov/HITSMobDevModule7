//
//  blur.swift
//  mob dev
//
//  Created by Тимофей Веретнов on 07.05.2021.
//  Copyright © 2021 Пользователь. All rights reserved.

//
//  GaussianBlur.swift
//
//  Created by Aryaman Sharda on 9/12/20.
//  Copyright © 2020 com.DigitalBunker. All rights reserved.
//
import Foundation
import UIKit
import SwiftImage


final class GaussianBlur {
    
    static func createBlurredImage(radius: Int, image: UIImage,gottenBeginX: Int, gottenBeginY: Int, gottenX : Int, gottenY : Int) -> Image<RGBA<UInt8>> {
        let inputImage = Image<RGBA<UInt8>>(uiImage: image)
        var outputImage = Image<RGBA<UInt8>>(uiImage: image)
        let positionX : Int = gottenX
        let positionY : Int = gottenY
        let sigma = max(Double(radius / 2), 1)

        
        let kernelWidth = (2 * radius) + 1

        
        var kernel = Array(repeating: Array(repeating: 0.0, count: kernelWidth), count: kernelWidth)
        var sum = 0.0

        
        for x in -radius...radius {
            for y in -radius...radius {
                let exponentNumerator = Double(-(x * x + y * y))
                let exponentDenominator = (2 * sigma * sigma)

                let eExpression = pow(M_E, exponentNumerator / exponentDenominator)
                let kernelValue = (eExpression / (2 * Double.pi * sigma * sigma))

                
                kernel[x + radius][y + radius] = kernelValue
                sum += kernelValue
            }
        }

        
        for x in 0..<kernelWidth {
            for y in 0..<kernelWidth {
                kernel[x][y] /= sum
            }
        }

        let radiusBeginX: Int = gottenBeginX
        
        let radiusBeginY: Int = gottenBeginY
        
        for x in radiusBeginX..<(positionX - radiusBeginX) { // inputImage.width
            for y in radiusBeginY..<(positionY - radiusBeginY) { //inputImage.height

                var redValue = 0.0
                var greenValue = 0.0
                var blueValue = 0.0

                
                for kernelX in -radius...radius {
                    for kernelY in -radius...radius {

                       
                        let kernelValue = kernel[kernelX + radius][kernelY + radius]

                       
                        redValue += Double(inputImage[x - kernelX, y - kernelY].red) * kernelValue
                        greenValue += Double(inputImage[x - kernelX, y - kernelY].green) * kernelValue
                        blueValue += Double(inputImage[x - kernelX, y - kernelY].blue) * kernelValue
                    }
                }

                
                outputImage[x,y].red = UInt8(redValue)
                outputImage[x,y].green = UInt8((greenValue))
                outputImage[x,y].blue = UInt8(blueValue)
            }
        }

        return outputImage
    }
}

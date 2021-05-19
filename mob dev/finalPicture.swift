//
//  finalPicture.swift
//  mob dev
//
//  Created by spoonty on 5/19/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import Foundation
import UIKit
import SwiftImage

func makePicture() {
    if isFirst == true {
        rotationCounter = rotationCounter % 4
        while (rotationCounter > 0) {
            mainPicture = firstAlgo(img: mainPicture)
            rotationCounter -= 1
        }
    }
    
    if isThird == true {
        for resize in arrayOfSize {
            mainPicture = thirdAlgo(img: mainPicture, k: resize)
        }
    }
}

import UIKit
import SwiftImage

cos(45 * Double.pi / 180)
tan(45/2 * Double.pi/180)


let image = Image<RGBA<UInt8>>(named: "pictureForMob.jpg")!
let result = image.rotated(by: .pi/4)
result.uiImage
                                            

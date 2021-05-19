//import UIKit
//
//var str = "Hello, playground"
//
//let image = UIImage(named: "ggwp.jpg")
//
//let height = Int((image?.size.height)!)
//
//let width = Int((image?.size.width)!)
//
//let bitsPerComponent = Int(8)
//let bytesPerRow = 4 * width
//let colorSpace = CGColorSpaceCreateDeviceRGB()
//let rawData = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
//let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
//let CGPointZero = CGPoint(x: 0, y: 0)
//let rect = CGRect(origin: CGPointZero, size: (image?.size)!)
//
//
//
//let imageContext = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
//
//imageContext?.draw(image!.cgImage!, in: rect)
//
//let pixels = UnsafeMutableBufferPointer<UInt32>(start: rawData, count: width * height)
//
//for  y in 0..<200 {
//    for  x in 0..<200{
//        var p = pixels[x+y*width]
//        var tmp =  RGBAPixel(rawVal: p)
//        tmp.red = 255
//        p = RGBAPixel(rawVal: tmp.raw).raw
//        pixels[x+y*width] = p
//        
//        var p = pixels[x+y*width]
//        var tmp =  RGBAPixel(rawVal: p)
//
//        tmp.red = 255 - tmp.red
//        tmp.green = 255 - tmp.red
//        tmp.blue = 255 - tmp.blue
//        p = RGBAPixel(rawVal: tmp.raw).raw
//        pixels[x+y*width] = p
//
//        var p = pixels[x+y*width]
//        var tmp =  RGBAPixel(rawVal: p)
//        var total : UInt32  = UInt32(tmp.red) + UInt32(tmp.green) + UInt32(tmp.blue)
//        if total > 255 {
//            p = RGBAPixel(rawVal: 0).raw
//            pixels[x+y*width] = p
//        }
//        else {
//            p = RGBAPixel(rawVal: 0xFFFFFFFF).raw
//            pixels[x+y*width] = p
//        }
//        
//        var p = pixels[x+y*width]
//        var tmp =  RGBAPixel(rawVal: p)
//        var total = (tmp.blue + tmp.green + tmp.red)/3
//        tmp.blue = total
//        tmp.red = total + 40
//        tmp.green = total + 20
//        if (tmp.red > 255){
//            tmp.red  = 255
//        }
//        if (tmp.green > 255){
//            tmp.green = 255
//        }
//        p = RGBAPixel(rawVal: tmp.raw).raw
//        pixels[x+y*width] = p
//    }
//}
//let outContext = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRow,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
//
//let outImage = UIImage(cgImage: outContext!.makeImage()!)
//
//
//

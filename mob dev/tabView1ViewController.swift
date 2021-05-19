//
//  tabView1ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/14/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit
import SwiftImage

var rotationCounter: Int = 0
var isFirst: Bool = false
var firstAppear = true

class tabView1ViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loading()
        //waiting.hidesWhenStopped = true
        //dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dismiss(animated: false, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        if firstAppear == true {
            loading()
            waiting.stopAnimating()
            waiting.hidesWhenStopped = true
            firstAppear = false
        } else {
            img.image = picture
        }
    }
    
    func loading() {
        img.image = picture
        let tmp = Image<RGBA<UInt8>>(uiImage: mainPicture)
        let height = tmp.height
        let width = tmp.width
        if (height >= 512 || width >= 512) {
            let size = 512
            var newHeight: Int = size, newWidth: Int = size
            if height >= width {
                    newWidth = Int((width*size)/height)
            } else {
                newHeight = Int((height*size)/width)
            }
            picture = tmp.resizedTo(width: newWidth, height: newHeight, interpolatedBy: .nearestNeighbor).uiImage
        } else {
            picture = mainPicture
        }
        img.image = picture
    }
    
    @IBAction func rotate(_ sender: Any) {
        img.image = firstAlgo(img: img.image!)
        picture = img.image!
        rotationCounter += 1
        isFirst = true
    }
}

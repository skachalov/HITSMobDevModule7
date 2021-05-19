//
//  testViewController.swift
//  mob dev
//
//  Created by spoonty on 5/14/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class testViewController: UITabBarController {
    
//    var picture: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func saveImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(picture, self, nil, nil)
    }
}

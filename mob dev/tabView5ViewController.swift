//
//  tabView5ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/16/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class tabView5ViewController: UIViewController {

    
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }

    @IBAction func FindFace(_ sender: Any) {
        let tmp = OCVWrapper.classifyImage(img.image)
          if ( tmp != nil){
              img.image = tmp
          }
    }
    
}

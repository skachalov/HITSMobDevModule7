//
//  tabView7ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/21/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class tabView7ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }

}

//
//  tabView6ViewController.swift
//  mob dev
//
//  Created by Тимофей Веретнов on 21.05.2021.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class tabView6ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        img.image = picture
    }

}

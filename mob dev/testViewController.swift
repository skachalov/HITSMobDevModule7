//
//  testViewController.swift
//  mob dev
//
//  Created by spoonty on 5/14/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class testViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.systemOrange
    }

    @IBAction func saveImage(_ sender: Any) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "saver") as! saverViewController
        self.navigationController?.pushViewController(next, animated: true)
    }

}

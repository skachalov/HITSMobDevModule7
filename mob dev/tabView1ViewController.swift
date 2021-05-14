//
//  tabView1ViewController.swift
//  mob dev
//
//  Created by spoonty on 5/14/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import UIKit

class tabView1ViewController: UIViewController {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pictureImageView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

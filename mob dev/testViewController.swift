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
//        print(picture)
//        UIImageWriteToSavedPhotosAlbum(picture, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "saver") as! saverViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
//    
//    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if let error = error {
//            let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//        } else {
//            let ac = UIAlertController(title: "Saved", message: "Your image has been saved to your photos", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
//        }
//    }
}

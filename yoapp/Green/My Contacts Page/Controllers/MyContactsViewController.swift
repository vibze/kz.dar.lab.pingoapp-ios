//
//  MyContactsViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class MyContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        backImageSet()
    }
    
    func backImageSet() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "contactsBackground")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST Lable my contacts"
        label.font = UIFont(name: "", size: 20)
        return label
    }()
}

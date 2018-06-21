//
//  AuthViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/20/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    // TEST SAMPLE
    
    let nametest = "Ayan"
    let emailtest = "qwe@mail.com"
    let passwordtest = "Qwerty123"

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User(name: nametest, email: emailtest, password: passwordtest)
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: "user")
        userDefaults.synchronize()
        view.backgroundColor = .red
    }
    
}

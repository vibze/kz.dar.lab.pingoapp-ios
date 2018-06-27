//
//  CustomNavBarView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 26.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class CustomNavBarView: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(bactToVC))
    }
    
    static func addNavCon(vc: UIViewController,backgrounColor: UIColor, title: String) {
        vc.navigationController?.navigationBar.isTranslucent = false
        vc.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.barTintColor = backgrounColor
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(bactToVC))
    }
    
    static func addRightBtutton(vc: UIViewController, action:Selector?) {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "add_icon"), style: .plain, target: self, action: action)
        vc.navigationItem.rightBarButtonItem = button
    }
    
    @objc func bactToVC() {
        print("Helllo")
//        self.navigationController?.popViewController(animated: true)
    }
}

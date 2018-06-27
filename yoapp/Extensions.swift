//
//  Extensions.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static let myPurple = UIColor(hexString: "9C4572")
    static let myOrange = UIColor(hexString: "FB984B")
    static let myYellow = UIColor(hexString: "FFB934")
    static let backgroundYellow = UIColor(hexString: "FEC95F")
}

extension UIViewController {
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.gestureRecognizers?.removeAll()
        view.endEditing(true)
    }
}

extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension UITableViewController {
    
    @objc func bactToVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openViewController(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UINavigationController {
    /*
    func tempChanges(backgrounColor: UIColor, title: String){
        self.navigationBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 150)
        self.navigationBar.barTintColor = backgrounColor
        self.navigationBar.topItem?.title = title
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(bactToVC))
        navigationController?.navigationBar.isTranslucent = false
    }*/
}


extension UIView {
    func basic(backgroundColor: UIColor) -> UIView{
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = backgroundColor
        return view
    }
}

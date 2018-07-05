//
//  Extensions.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

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
    
    func openViewController(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func addNavCon(backgrounColor: UIColor, title: String){
        navigationController?.navigationBar.barTintColor = backgrounColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 18)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(bactToVC))
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(bactToVC))
        gesture.direction = .right
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func bactToVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addRightBtutton( action:Selector?) {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "add_icon"), style: .plain, target: self, action: action)
        navigationItem.rightBarButtonItem = button
    }
    
    func handleError(with statusCode: Int) {
        switch statusCode {
        case 404:
            showAlert(errorType: "Failed Error 404", image: #imageLiteral(resourceName: "errorIcon"))
        default:
            break
        }
    }
    
    func showAlert(errorType: String, image: UIImage){
        let alertView = AlertViewController()
        alertView.errorView(errorType: errorType, image: image)
        self.present(alertView, animated: false, completion: nil)
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

extension UILabel {
    
    static func basic(textColor: UIColor, fontSize: CGFloat, fontType: FontType) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: fontType.rawValue, size: fontSize)
        label.textColor = textColor
        return label
    }
    
    static func rounded(textColor: UIColor, fontSize: CGFloat, fontType: FontType, backgroundColor:UIColor) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.backgroundColor = backgroundColor
        label.layer.cornerRadius = 10
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: fontType.rawValue, size: fontSize)
        label.textColor = textColor
        return label
    }

}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}

extension String {
    func crop(begin: Int, end: Int) -> String {
        let lowerBound = index(self.startIndex, offsetBy: begin)
        let upperBound = index(self.startIndex, offsetBy: end)
        let mySubstring = String(self[lowerBound..<upperBound])
        
        return mySubstring
    }
}


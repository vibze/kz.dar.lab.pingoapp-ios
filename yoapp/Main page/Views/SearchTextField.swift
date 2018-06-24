//
//  SearchTextField.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class SearchTextField: UITextField {
    
    private let padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
    private let paddingActive: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    required init() {
        super.init(frame: .zero)
        self.borderStyle = .none
        self.font = UIFont(name: "Avenir Next", size: 16)
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35).cgColor
        self.backgroundColor = UIColor.init(hexString: "58AD7E")
        self.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = #imageLiteral(resourceName: "search")
        self.leftView = imageView
        self.leftView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        self.leftViewMode = UITextFieldViewMode.always
        self.leftViewMode = .always
        self.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

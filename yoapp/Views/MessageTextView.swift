//
//  MessageTextView.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/11/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class MessageTextView: UITextView {
    required init() {
        super.init(frame: .zero, textContainer: nil)
        layer.masksToBounds = true
        layer.cornerRadius = 10
        isUserInteractionEnabled = true
        layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.6274509804, blue: 0.4745098039, alpha: 1).cgColor
        layer.borderWidth = 5
        font = UIFont(name: "Avenir Next", size: 18)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

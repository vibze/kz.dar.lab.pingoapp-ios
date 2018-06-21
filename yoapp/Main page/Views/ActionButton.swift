//
//  CustomButton.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class ActionButton: UIButton {
    
    /**
     Write - yellow button (MessageVC)
     Block - green button (MessageVC)
     */
    enum ActionButtonType {
        case write
        case block
        
        var backgroundColor: UIColor {
            switch self {
            case .write: return UIColor(hexString: "FFC65B")
            case .block: return UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
            }
        }
        
        var mainColor: UIColor {
            switch self {
            case .write: return UIColor(hexString: "308757")
            case .block: return UIColor(hexString: "AA4778")
            }
        }
    }

    required init(title: String, type: ActionButtonType) {
        
        super.init(frame: .zero)
        
        self.backgroundColor = type.backgroundColor
        self.setTitleColor(type.mainColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = type.mainColor.cgColor
        self.layer.borderWidth = 5
        self.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

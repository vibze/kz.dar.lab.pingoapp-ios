//
//  TabBarButton.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class TabBarButton: UIButton {
    enum TabBarButtonType {
        case home
        case contacts
        case profile
        
        var image: UIImage {
            switch self {
            case .home:
                return #imageLiteral(resourceName: "homeSelected")
            case .contacts:
                return #imageLiteral(resourceName: "contacts")
            case .profile:
                return #imageLiteral(resourceName: "profile")
            }
        }
    }
    
    required init(tag: Int, type: TabBarButtonType) {
        super.init(frame: .zero)
        self.tag = tag
        setImage(type.image, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

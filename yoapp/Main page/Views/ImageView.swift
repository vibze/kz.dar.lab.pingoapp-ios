//
//  CustomImageView.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class ImageView: UIImageView {
    required init(radius: CGFloat) {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor(hexString: "E36980").cgColor
        self.layer.borderWidth = 3
        self.image = #imageLiteral(resourceName: "contactPlaceholder")
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


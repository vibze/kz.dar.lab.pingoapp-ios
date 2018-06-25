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
    
    let underline = CALayer()
    
    required init(tag: Int, image: UIImage) {
        super.init(frame: .zero)
        self.tag = tag
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        underline.backgroundColor = UIColor.white.cgColor
        underline.isHidden = true
        layer.addSublayer(underline)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            underline.isHidden = !isSelected
            layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        underline.frame = CGRect(x: 10, y: frame.height - 3, width: frame.width - 20, height: 3)
        imageView?.transform = isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) :
            CGAffineTransform(scaleX: 1, y: 1)
        
    }
}

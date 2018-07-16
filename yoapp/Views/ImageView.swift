//
//  CustomImageView.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class ImageView: UIImageView {
    
    var imageUrlString: String?
    
    required init(radius: CGFloat) {
        super.init(frame: .zero)
        layer.masksToBounds = true
        layer.borderColor = UIColor(hexString: "E36980").cgColor
        layer.borderWidth = 4
        image = #imageLiteral(resourceName: "contactPlaceholder")
        contentMode = .scaleAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContactImage(url: String) {
        af_setImage(withURL: URL(string: Urls.baseUrl + url)!, placeholderImage: #imageLiteral(resourceName: "contactPlaceholder"))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }
}


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
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor(hexString: "E36980").cgColor
        self.layer.borderWidth = 3
        self.image = #imageLiteral(resourceName: "contactPlaceholder")
        self.contentMode = .scaleAspectFill
        setActivityIndicator()
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .red
        return indicator
    }()
    
    private func setActivityIndicator() {
        self.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContactImage(url: String) {
        self.image = #imageLiteral(resourceName: "contactPlaceholder")
        
        let url = Urls.baseUrl + url
        activityIndicator.startAnimating()
        Avatar.getAvatar(url: url, success: { (avatarImage) in
            self.activityIndicator.stopAnimating()
            UIView.transition(with: self,
                              duration: 0.75,
//                              options: .transitionCrossDissolve,
                              animations: { self.image = avatarImage },
                              completion: nil)
        
        }) { (error) in
            self.activityIndicator.stopAnimating()
            guard let error = error else { return }
            print(error)
        }
    }
}


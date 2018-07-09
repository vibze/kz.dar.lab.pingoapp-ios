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

let avatarImageCache = AutoPurgingImageCache(
    memoryCapacity: 100_000_000,
    preferredMemoryUsageAfterPurge: 60_000_000
)

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
        guard let tempUrl = URL(string: Urls.baseUrl + url) else { return }
        image = #imageLiteral(resourceName: "contactPlaceholder")
        activityIndicator.startAnimating()
        af_setImage(withURL: tempUrl, placeholderImage: #imageLiteral(resourceName: "contactPlaceholder"), filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(1), runImageTransitionIfCached: false) { (response) in
            if let data = response.data {
                avatarImageCache.add(UIImage(data: data)!, for: URLRequest(url: tempUrl))
            }
            self.activityIndicator.stopAnimating()
        }
    }
}


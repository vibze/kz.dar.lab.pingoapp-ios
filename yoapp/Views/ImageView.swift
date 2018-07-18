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
    
    required init() {
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
        let urlRequest = URLRequest(url: URL(string: Urls.baseUrl + url)!)
        let imageDownloader = af_imageDownloader ?? UIImageView.af_sharedImageDownloader
        let imageCache = imageDownloader.imageCache
        let result = imageCache?.removeImage(for: urlRequest, withIdentifier: nil)
        print("is image removed from cache", result!)
        
        af_setImage(withURL: URL(string: Urls.baseUrl + url)!, placeholderImage: #imageLiteral(resourceName: "contactPlaceholder"), filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}


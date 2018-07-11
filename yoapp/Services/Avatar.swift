//
//  Avatar.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/11/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let avatarImageCache = AutoPurgingImageCache(
    memoryCapacity: 100_000_000,
    preferredMemoryUsageAfterPurge: 60_000_000
)

struct Avatar {
    
    static func getAvatar(url: String, success: @escaping (UIImage) -> Void, error: @escaping (String?) -> Void) {
        Alamofire.request(url, method: .get).responseImage { (response) in
            if let data = response.data, let avatarImage = UIImage(data: data) {
                avatarImageCache.add(avatarImage, withIdentifier: url)
                success(avatarImage)
                return
            }
            if let avatarImage = avatarImageCache.image(withIdentifier: url) {
                success(avatarImage)
                return
            }
            error(response.error?.localizedDescription)
        }
    }
}

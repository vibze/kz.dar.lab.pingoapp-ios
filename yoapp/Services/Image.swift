//
//  GetImage.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/4/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Alamofire

class Image {
    func getProfileImage(url: String, _ completion: @escaping (Data?, String?) -> Void) {
        let baseUrl = Urls.baseUrl + url
        print(baseUrl)
        Alamofire.request(baseUrl, method: .get).response { (response) in
            completion(response.data, response.error?.localizedDescription)
        }
    }
}

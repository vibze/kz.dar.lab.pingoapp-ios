//
//  Post.swift
//  yoapp
//
//  Created by Arthur Belyankov on 28.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileAPI {
    static func registerDeviceToken(token: String, success: @escaping (Profile)-> Void, failure: @escaping (String) -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = "http://178.62.123.161/api/v1/profile/register_device_token"
        
        let parameters: Parameters = ["device_token": token, "provider": "apns"]
        /*
        request(url, method: .post, parameters: parameters, success: {
            
        }, failure: { error in
            
        })
 */
    }
}
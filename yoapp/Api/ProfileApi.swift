//
//  ProfileApi.swift
//  yoapp
//
//  Created by Arthur Belyankov on 04.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ProfileApi: BaseAPI {
    
    func uploadDeviceToken(deviceToken: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void){
        let parameters = ["device_token" : deviceToken, "provider":"apns"]
     
        post(url: "profile/register_device_token", params: parameters, success: { (json) in
            print(json)
        }) { (Error) in
            print("error")
        }
    }
}

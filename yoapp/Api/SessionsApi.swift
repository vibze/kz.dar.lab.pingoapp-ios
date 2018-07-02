//
//  SessionApi.swift
//  yoapp
//
//  Created by Arthur Belyankov on 26.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SessionsApi: BaseAPI {
    
    static func createSession (token: String, success: @escaping(Profile)->Void, failure: @escaping (String) -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = "http://178.62.123.161/api/v1/sessions/new"
        
        let parameters: Parameters = ["account_kit_access_token" : token]
        
        Alamofire.request(url, method: .post, parameters: parameters).validate().responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                let phoneNumber = json["profile"]["phoneNumber"].stringValue
                let avatarImageUrl = json["profile"]["avatarImageUrl"].stringValue
                let profile = Profile(phoneNumber: phoneNumber, avatarImageUrl: avatarImageUrl)
                success(profile)
            }
            else {
                failure("Не удалось зайти")
            }
        }
    }
    
//    static func deleteSession (success: @escaping(Profile)->Void, failure: @escaping (String) -> Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//        let url = "http://178.62.123.161/api1/v1/sessions/delete"
//
//        Alamofire.request(url, method: .delete).validate().responseJSON { (response) in
//            if let value = response.result.value {
//                let sc = JSON(value)["profile"]["success"].stringValue
//                success(sc)
//
//            }
//            else {
//                failure("Не удалось удалить")
//            }
//        }
//    }
}

//
//  Pings.swift
//  yoapp
//
//  Created by Arthur Belyankov on 09.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class PingsApi: BaseAPI {
    
    func postPing(buddyId: Int32, pingText: String, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void){
       
        let parameters: [String: Any] = ["buddy_id" : buddyId, "ping_text": pingText]
        
        post(url: "pings/new", params: parameters, success: { (json) in
            print(json)
            success(json)
        }) { (Error) in
            print("error")
            failure("error1")
        }
    }
}

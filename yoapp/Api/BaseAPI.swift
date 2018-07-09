//
//  BaseAPI.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/2/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Alamofire
import SwiftyJSON


class BaseAPI {
    let base = Urls.base
    
    func get(url: String, params: Parameters, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void) {
        request(method: .get, url: base + url, params: params, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    func post(url: String, params: Parameters, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void) {
        request(method: .post, url: url, params: params, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    func put(url: String, params: Parameters, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void) {
        request(method: .put, url: url, params: params, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    func delete(url: String, params: Parameters, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void) {
        request(method: .delete, url: url, params: params, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    private func request(method: HTTPMethod, url: String, params: Parameters, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void) {
        guard let token = Profile.current()?.authorizationToken else { return }
        
        let headers = ["Authorization": "Bearer \(token)"]
        
        Alamofire.request(base + url, method: method, parameters: params, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                success(JSON(value))
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}

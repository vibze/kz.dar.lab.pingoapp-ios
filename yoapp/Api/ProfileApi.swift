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
    
    func uploadDeviceToken(success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void){
//        guard
//        let url = Urls.base
        let header = ["Authorization": "Bearer \(Token.shared.accessToken)"]
        let parameters = ["device_token" : Token.shared.deviceToken, "provider":"apns"]
        
        
//        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)(multipartFormData: { data in
//            data.append(key:"device_token",value: Token.shared.deviceToken)
//            data.append(key:"provider",value: "apns")
//        }, to: url, method: .post, headers: header)
        post(url: "profile/register_device_token", params: parameters, success: { (json) in
            print(json)
        }) { (Error) in
            print("error")
        }
    }
    
    
    /*
     func uploadImage(avatar: UIImage, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void){
     guard
     let imageData = UIImageJPEGRepresentation(avatar, 1.0),
     let url = URL(string: "http://178.62.123.161api/v1/profile/register_device_token") else {
     return
     }
     
     let header = ["Content-Type": "application/x-www-form-urlencoded",
     "Authorization": "Bearer \(Token.shared.accessToken!.tokenString)",
     "Accept":"application/json"]
     print(Token.shared.accessToken!.tokenString)
     
     Alamofire.upload(multipartFormData: { data in
     data.append(imageData, withName: "file", fileName: "myImage.png", mimeType: "image/png")
     }, to: url, method: .post, headers: header) { result in
     switch result {
     case .success(request: let uploadRequest, _, _):
     uploadRequest.validate(statusCode: 200..<600).responseJSON(completionHandler: {dataResponse in
     if dataResponse.result.isSuccess {
     print(dataResponse, "RESPONSE!!")
     let statusCode = dataResponse.response!.statusCode
     self.handleError(with: statusCode)
     } else {
     guard let error = dataResponse.error else { return }
     failure(error)
     }
     })
     case .failure(let error):
     failure(error)
     }
     }
     }
     */
}

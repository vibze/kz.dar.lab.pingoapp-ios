//
//  ProfileImageUpload.swift
//  yoapp
//
//  Created by Kamila Kusainova on 15.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Alamofire
import CoreStore

struct ProfileImageUpload {
    
    static func uploadImage(avatar: UIImage, success: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void){
        guard
            let imageData = UIImageJPEGRepresentation(avatar, 0.3),
            let url = URL(string: Urls.getUrl(.avatarUpload)) else {
                return
        }
        let token = UserDefaults().getAccessToken()
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Authorization": "Bearer \(token)",
                      "Accept":"application/json"]
        
        Alamofire.upload(multipartFormData: { data in
            data.append(imageData, withName: "file", fileName: "myImage.png", mimeType: "image/png")
        }, to: url, method: .post, headers: header) { result in
            switch result {
            case .success(request: let uploadRequest, _, _):
                uploadRequest.validate(statusCode: 200..<600).responseJSON(completionHandler: {dataResponse in
                    if dataResponse.result.isSuccess {
                        success(dataResponse.result.isSuccess)
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
    
    
}

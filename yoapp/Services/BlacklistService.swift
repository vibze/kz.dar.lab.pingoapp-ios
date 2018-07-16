//
//  Message.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/4/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

class BlacklistService: BaseAPI {

    func blacklistContact(profileId: Int32, _ success: @escaping () -> Void, _ failure: @escaping (String?) -> Void) {
        let url = "buddies/\(profileId)/blacklist"
        put(url: url, params: [:], success: { (json) in
            let result = json["success"].boolValue
            if result {
                Store.updateContactInCore(profileId: profileId, isBlacklisted: true, {
                    success()
                }, { (error) in
                    failure(error)
                })
                return
            }
            failure("some error")
        }) { (err) in
            failure(err)
        }
    }
    
    func unblacklistContact(profileId: Int32, _ success: @escaping () -> Void, _ failure: @escaping (String) -> Void) {
        let url = "buddies/\(profileId)/unblacklist"
        delete(url: url, params: [:], success: { (json) in
            let result = json["success"].boolValue
            if result {
                Store.updateContactInCore(profileId: profileId, isBlacklisted: false, {
                    success()
                }, { (error) in
                    guard let error = error else { return }
                    failure(error)
                })
                return
            }
        }) { (err) in
            failure(err)
        }
    }
}

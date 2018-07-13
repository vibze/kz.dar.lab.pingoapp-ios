//
//  Message.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/4/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore

class Message: BaseAPI {
    //TODO: Переписать Аяну
    func performBlock(profileId: Int32, isBlacklisted: Bool, _ completion: @escaping (String?) -> Void) {
        if isBlacklisted {
            unblacklistContact(profileId: profileId) { (message) in
                if let message = message {
                    completion(message)
                    return
                }
                completion(nil)
            }
            return
        }
        blacklistContact(profileId: profileId) { (message) in
            if let message = message {
                completion(message)
                return
            }
            completion(nil)
        }
    }
    
    //TODO: поменять логику, с completion-ом, дописать failure. Аян
    private func blacklistContact(profileId: Int32, _ completion: @escaping (String?) -> Void) {
        let url = "buddies/\(profileId)/blacklist"
        put(url: url, params: [:], success: { (json) in
            let result = json["success"].boolValue
            if result {
                self.updateContactInCore(profileId: profileId, isBlacklisted: true)
                completion(nil)
                return
            }
            completion("Some error")
        }) { (err) in
            completion(err)
        }
    }
    
    //TODO: заюзать, написать сервис для контактов. Камила.
    private func unblacklistContact(profileId: Int32, _ completion: @escaping (String?) -> Void) {
        let url = "buddies/\(profileId)/unblacklist"
        delete(url: url, params: [:], success: { (json) in
            let result = json["success"].boolValue
            if result {
                self.updateContactInCore(profileId: profileId, isBlacklisted: false)
                completion(nil)
                return
            }
            completion("Some error")
        }) { (err) in
            completion(err)
        }
    }
    
    private func updateContactInCore(profileId: Int32, isBlacklisted: Bool) {
        CoreStore.perform(asynchronous: {
            let contact = $0.fetchOne(From<Contact>().where(\.profileId == profileId))
            contact?.isBlacklisted = isBlacklisted
        }) { (result) in
            switch result {
            case .success: print("contact is updated")
            case .failure: print("error")
            }
        }
    }
}

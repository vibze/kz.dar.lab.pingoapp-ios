//
//  Store.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/26/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore

class Store {

    static func initCoreStore() {
        CoreStore.defaultStack = DataStack (
            xcodeModelName: "app",
            bundle: Bundle.main,
            migrationChain: []
        )
        do {
            try CoreStore.addStorageAndWait()
        }
        catch let error {
            print(error)
        }
    }
    
    // Clean core store
    static func cleanCoreStore() {
        CoreStore.perform(
            asynchronous: {
                $0.deleteAll(From<Contact>())
            },
            completion: { (result) -> Void in
                switch result {
                case .success: print("success!")
                case .failure(let error): print(error)
                }
            }
        )
    }
    
    static func updateContactPingTime(phoneNumber: String, date: Date) {
        CoreStore.perform(
            asynchronous: {
                let contact = $0.fetchOne(From<Contact>().where(\.phoneNumber == phoneNumber))
                contact?.pingedAt = date
            },
            completion: { (result) -> Void in
                switch result {
                case .success: print("success!")
                case .failure(let error): print(error)
                }
            }
        )
    }
    
    static func addDefaultPhrases() {
        let favoriteWords = ["Привет", "Как дела?"]
        CoreStore.perform(
            asynchronous: {
                if $0.fetchAll(From<FavoriteWords>())?.count == 0 {
                    for word in favoriteWords {
                        let favoritePhrases = $0.create(Into<FavoriteWords>())
                        favoritePhrases.word = word
                    }
                }
            },
            completion: { (result) -> Void in
                switch result {
                case .success:
                    print("added default phrases")
                case .failure(let error):
                    print(error)
                }
            }
        )
    }
    
    static func addPhrase(phrase: String) {
        CoreStore.perform(asynchronous: {
            let existedPhrase = $0.fetchOne(From<FavoriteWords>().where(\.word == phrase))
            if existedPhrase == nil {
                let phrases = $0.create(Into<FavoriteWords>())
                phrases.word = phrase
            }
        }) { (result) in
            switch result {
            case .success:
                print("success")
            case .failure:
                print("failure")
            }
        }
    }
    
    static func updateContactInCore(profileId: Int32, isBlacklisted: Bool,
                                    _ success: @escaping () -> Void, _ failure: @escaping (String?) -> Void) {
        CoreStore.perform(asynchronous: {
            let contact = $0.fetchOne(From<Contact>().where(\.profileId == profileId))
            contact?.isBlacklisted = isBlacklisted
        }) { (result) in
            switch result {
            case .success:
                success()
                print("contact is updated")
            case .failure(let error):
                failure(error.localizedDescription)
                print("error")
            }
        }
    }
}

//
//  Store.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/26/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore
import Contacts

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
    
    static func updateContactPingTime(phoneNumber: String) {
        CoreStore.perform(
            asynchronous: {
                let contact = $0.fetchOne(From<Contact>().where(\.phoneNumber == phoneNumber))
                contact?.pingedAt = Date()
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
}

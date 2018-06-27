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
            migrationChain: []
        )
    }
    
    enum coreOperationType {
        case clean, write, read
    }

    static func writeToCoreStore(_ contacts: [MyContact]) {
        do {
            try CoreStore.addStorageAndWait()
            CoreStore.perform(
                asynchronous: {
                    for myContact in contacts {
                        let contact = $0.create(Into<Contact>())
                        contact.phoneNumber = myContact.phoneNumber
                        contact.name = myContact.name
                    }
            },
                completion: { (result) -> Void in
                    switch result {
                    case .success: print("success!")
                    case .failure(let error): print(error)
                    }
            }
            )
        }
        catch let error {
            print(error)
        }
    }
    static func fetchFromCoreStore(_ completion: @escaping ([MyContact]?, String?) -> Void) {
        do {
            try CoreStore.addStorageAndWait()
            CoreStore.perform(
                asynchronous: {
                    let contactsData = $0.fetchAll(From<Contact>())
                    if let contactsData = contactsData {
                        if contactsData.count == 0 {
                            completion(nil, "Error, core store is empty")
                        }
                        var myContacts: [MyContact] = []
                        for contact in contactsData {
                            let existedContact = MyContact(avatarUrl: contact.avatarUrl,
                                                           isBlackListed: contact.isBlacklisted,
                                                           name: contact.name,
                                                           phoneNumber: contact.phoneNumber,
                                                           pingedAt: contact.pingedAt,
                                                           profileId: contact.profileId)
                            
                            myContacts.append(existedContact)
                        }
                        completion(myContacts, nil)
                    }
                },
                completion: { (result) -> Void in
                    switch result {
                    case .success: print("success!")
                    case .failure(let error): print(error)
                    }
                }
            )
        }
        catch let error {
            print(error)
        }
    }
    
    
    // Clean core store
    static func cleanCoreStore() {
        do {
            try CoreStore.addStorageAndWait()
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
        catch let error {
            print(error)
        }
    }
}

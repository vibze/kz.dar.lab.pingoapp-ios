//
//  Contact.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/24/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Contacts
import CoreStore

struct ContactsService {
    var contact: CNContact?
    var isRegistered: Bool = false
    
    static func syncContacts(_ completion: @escaping ([ContactsService]?, String?) -> Void) {
        let store = CNContactStore()
        var contacts: [ContactsService] = []
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                completion(nil, error as? String)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, sd) in
                        contacts.append(ContactsService(contact: contact, isRegistered: false))
                    })
                } catch let error {
                    completion(nil, error as? String)
                }
            }
            else {
                completion(nil, "Access denied")
            }
            completion(contacts, nil)
        }
    }
    
//    private static func writeToCoreData(_ contact: CNContact) {
//        CoreStore.defaultStack = DataStack(
//            xcodeModelName: "app",
//            migrationChain: []
//        )
//        CoreStore.perform(
//            asynchronous: { (transaction) -> Void in
////                let person = transaction.create(Into<MyPersonEntity>())
//                person.name = "John Smith"
//                person.age = 42
//        },
//            completion: { (result) -> Void in
//                switch result {
//                case .success: print("success!")
//                case .failure(let error): print(error)
//                }
//            }
//        )
//    }
}

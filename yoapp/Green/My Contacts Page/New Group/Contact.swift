//
//  Contact.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/24/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import Contacts

struct MyContacts {
    static func fetchContacts(_ completion: @escaping ([CNContact]?, String?) -> Void) {
        let store = CNContactStore()
        var contacts: [CNContact] = []
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
                        contacts.append(contact)
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
}

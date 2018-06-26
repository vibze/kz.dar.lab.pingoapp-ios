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
//    static var contactsMonitor: ListMonitor<Contact> {
//        let monitor = CoreStore.monitorList(
//            From<Contact>()
//        )
//
//        monitor[indexPath]
//    }
    
    static func getContacts(_ completion: @escaping ([MyContact]?, String?) -> Void) {
        Store.fetchFromCoreStore({ (data, message) in
            if let message = message {
                print(message)
                syncContacts({ (contacts, message) in
                    if let message = message {
                        print (message)
                        completion(nil, message)
                    }
                    else {
                        if let contacts = contacts {
                            Store.writeToCoreStore(contacts)
                            completion(contacts, nil)
                        }
                    }
                })
            }
            else {
                if let data = data {
                    completion(data, nil)
                }
            }
        })
    }
    
    private static func syncContacts(_ completion: @escaping ([MyContact]?, String?) -> Void) {
        let store = CNContactStore()
        var contacts: [MyContact] = []
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
                        let fetchedContact = MyContact(name: contact.givenName,
                                                       phoneNumber: contact.phoneNumbers.first?.value.stringValue)
                        contacts.append(fetchedContact)
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

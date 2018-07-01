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
    
    static var contactsMonitor: ListMonitor<Contact> = {
        let monitor = CoreStore.monitorList(
            From<Contact>()
                .orderBy(.ascending(\.name))
        )
        return monitor
    }()
    
    func syncContacts() {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        let phoneNumbers: [String] = []
    
        requestAccessToContacts { store in
            CoreStore.perform(
                asynchronous: { (transaction) -> Void in
                    do {
                        try store.enumerateContacts(with: request, usingBlock: { (contact, sd) in
                            // phoneNumbers.append(contact.phoneNumbers.)
                            guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue, transaction.fetchOne(From<Contact>().where(\.phoneNumber == phoneNumber)) == nil else {
                                return
                            }
                            
                            let newContact = transaction.create(Into<Contact>())
                            newContact.phoneNumber = phoneNumber
                            newContact.name = contact.givenName
                        })
                    } catch let error {
                        //completion(nil, error as? String)
                    }
                },
                completion: { (result) -> Void in
                    switch result {
                    case .success: self.checkPhoneNubmersForRegistration(phoneNumber: phoneNumbers)
                    case .failure(let error): print(error)
                    }
                }
            )
        }
    }
    
    func requestAccessToContacts(_ completion: @escaping (CNContactStore) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                return
            }
            if granted {
                completion(store)
            }
        }
    }
    
    func checkPhoneNubmersForRegistration(phoneNumber: [String]) {
        // Make request to backend
        // Receive a list of buddies
        // Iterate over received list
    }
}

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
import Alamofire
import SwiftyJSON

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
        var phoneNumbers: [String] = []
    
        requestAccessToContacts { store in
            CoreStore.perform(
                asynchronous: { (transaction) -> Void in
                    do {
                        try store.enumerateContacts(with: request, usingBlock: { (contact, sd) in
                            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                                if transaction.fetchOne(From<Contact>().where(\.phoneNumber == phoneNumber)) == nil {
                                    let newContact = transaction.create(Into<Contact>())
                                    newContact.phoneNumber = phoneNumber
                                    newContact.name = contact.givenName
                                }
                                phoneNumbers.append(phoneNumber)
                            }
                        })
                    } catch let error {
                        print(error)
                    }
                },
                completion: { (result) -> Void in
                    switch result {
                    case .success:
                        self.checkPhoneNubmersForRegistration(phoneNumbers: phoneNumbers)
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
                debugPrint(error)
                return
            }
            if granted {
                completion(store)
            }
        }
    }
    
    func checkPhoneNubmersForRegistration(phoneNumbers: [String]) {
        let url = Urls.getUrl(.buddies)
        let tokenTest = "Bearer EMAWdQD4ISxKG6BXvYjcsOxVz8BbehjDuc29QAnOxRUnRU0AmKyhrajLZAaHklyIO5inpMDaui9Tamq1gFJOaX0J5pJIZBCQMsejiA9RpAZDZD"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(tokenTest, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: phoneNumbers)
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case .success(let value):
                break
//                print("response json:" , value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getRegisteredContacts(_ completion: @escaping ([[Contact]?]) -> Void) {
        CoreStore.perform(
            asynchronous: {
                let registeredContacts = $0.fetchAll(From<Contact>().where(\.profileId != 0))
                let lastActiveContacts = $0.fetchAll(From<Contact>().where(\.profileId != 0).orderBy(.ascending(\.pingedAt)))
                
                completion([lastActiveContacts, registeredContacts])
            },
            completion: { (result) -> Void in
                switch result {
                case .success: print("success")
                case .failure(let error): print(error)
                }
            }
        )
    }
    
    func updateContacts() {
        CoreStore.perform (
            asynchronous: { (transaction) -> Void in
                let contact = transaction.fetchOne(From<Contact>().where(\.phoneNumber == ""))
                contact?.profileId = 13
            },
            completion: { (result) -> Void in
                switch result {
                case .success: print("success")
                case .failure(let error): print(error)
                }
            }
        )
    }
}

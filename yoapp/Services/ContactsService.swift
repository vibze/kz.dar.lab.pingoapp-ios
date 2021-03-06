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
                                let normalizedPhoneNumber = ContactsOperation.changeNumberType(phoneNumber)
                                let myContact = transaction.fetchOne(From<Contact>().where(\.phoneNumber == normalizedPhoneNumber))
                                if myContact == nil {
                                    let newContact = transaction.create(Into<Contact>())
                                    newContact.phoneNumber = normalizedPhoneNumber
                                    newContact.name = contact.givenName
                                }
                                else { // handle name change in Contacts
                                    let nameInCore = myContact?.name ?? ""
                                    if nameInCore != contact.givenName {
                                        myContact?.name = contact.givenName
                                    }
                                }
                                phoneNumbers.append(normalizedPhoneNumber)
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
    
    private func requestAccessToContacts(_ completion: @escaping (CNContactStore) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print(error)
                return
            }
            if granted {
                completion(store)
            }
        }
    }
    
    private func getRequest(_ body: [String]) -> URLRequest? {
        let url = Urls.getUrl(.buddies)
        guard var authToken = Profile.current()?.authorizationToken else { return nil }
        authToken = "Bearer " + authToken
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        return request
    }
    
    private func checkPhoneNubmersForRegistration(phoneNumbers: [String]) {
        guard let request = getRequest(phoneNumbers) else { return }
        handleDeletedContacts(phoneNumbers: phoneNumbers)
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.updateContactsIfNeeded(json: json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleDeletedContacts(phoneNumbers: [String]) {
        CoreStore.perform(
            asynchronous: { (transaction) -> Void in
                let allContacts = transaction.fetchAll(From<Contact>())
                guard let myContacts = allContacts else { return }
                for contact in myContacts {
                    var isDeletedContactFound = true
                    for number in phoneNumbers {
                        if contact.phoneNumber == number {
                            isDeletedContactFound = false
                            break
                        }
                    }
                    if isDeletedContactFound {
                        transaction.delete(contact)
                    }
                }
            },
            completion: { (result) -> Void in
                switch result {
                case .success: print("success")
                case .failure(let error): print(error)
                }
            }
        )
    }
    
    private func updateContactsIfNeeded(json: JSON) {
        CoreStore.perform(
            asynchronous: { (transaction) -> Void in
                for registered in json.arrayValue {    
                    let contact = transaction.fetchOne(From<Contact>().where(\.phoneNumber == registered["phone_number"].stringValue))
                    contact?.profileId = Int32(registered["id"].intValue)
                    let avatar = JSON(registered["avatar"]["thumb"])
                    let avatarUrl = avatar["url"].stringValue
                    contact?.avatarUrl = avatarUrl != "" ? avatarUrl : nil
                }
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

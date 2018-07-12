//
//  ContactsOperation.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/12/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

struct ContactsOperation {
    static func changeNumberType(_ number: String) -> String {
        var redeclaredNumber = ""
        for char in number {
            if char >= "0" && char <= "9" {
                redeclaredNumber += String(char)
            }
        }
        if redeclaredNumber.first == "8" {
            redeclaredNumber.removeFirst()
            return "7" + redeclaredNumber
        }
        return redeclaredNumber
    }
    
    static func sliceContactsList(_ recentlyActiveContacts: inout [Contact], _ registeredContacts: inout [Contact]) {
        var recentlyslicedContacts: [Contact] = []
        var registeredSlicedContacts: [Contact] = []
        for (index, contact) in recentlyActiveContacts.enumerated() {
            if let _ = contact.pingedAt, index < 8 {
                recentlyslicedContacts.append(contact)
            }
            else {
                registeredSlicedContacts.append(contact)
            }
        }
        registeredSlicedContacts = registeredSlicedContacts.sorted(by: {
            if let firstName = $0.name, let secondName = $1.name {
                return firstName < secondName
            }
            return false
        })

        registeredContacts = registeredSlicedContacts
        recentlyActiveContacts = recentlyslicedContacts
    }
}

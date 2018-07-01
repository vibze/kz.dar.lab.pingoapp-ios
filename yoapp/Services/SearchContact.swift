//
//  SearchContact.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 7/2/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore

struct SearchContact {
    static func searchFor(monitor: ListMonitor<Contact>, text: String?) -> [Contact] {
        var allContacts = monitor.objectsInAllSections()
        guard let searchText = text else { return allContacts }
        if searchText.count > 0 {
            allContacts = allContacts.filter {
                guard let name = $0.name,
                    let phoneNumber = $0.phoneNumber else { return false }
                if name.lowercased().range(of: searchText.lowercased()) != nil ||
                    phoneNumber.range(of: searchText) != nil {
                    return true
                } else {
                    return false
                }
            }
        }
        return allContacts
    }
}

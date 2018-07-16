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
        
        guard let newText = text?.lowercased() else { return allContacts }
        let searchText = removeSymbols(text: newText)
        if searchText.count > 0 {
            allContacts = allContacts.filter {
                guard let name = $0.name,
                    let phoneNumber = $0.phoneNumber else { return false }
                if name.lowercased().range(of: searchText) != nil ||
                    phoneNumber.range(of: searchText) != nil {
                    return true
                } else {
                    return false
                }
            }
        }
        return allContacts
    }
    
    private static func checkCharacter(_ char: Character) -> Bool {
        if char >= "0" && char <= "9" ||
            char >= "a" && char <= "z" ||
            char >= "а" && char <= "я" {
            return true
        }
        return false
    }
    
    private static func removeSymbols(text: String) -> String {
        var searchText = ""
        
        for char in text {
            if checkCharacter(char) || char == " " {
                searchText += String(char)
            }
        }
        let begin = removeExtraSpaces(searchText)
        let end = searchText.count - removeExtraSpaces(String(searchText.reversed()))
        return searchText.crop(begin: begin, end: end)
    }
    
    static func removeExtraSpaces(_ text: String) -> Int {
        for (index, char) in text.enumerated() {
            if char != " " {
                return index
            }
        }
        return 0
    }
}

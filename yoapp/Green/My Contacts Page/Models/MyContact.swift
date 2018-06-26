//
//  MyContact.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/26/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

struct MyContact {
    var avatarUrl: String?
    var isBlackListed: Bool?
    var name: String?
    var phoneNumber: String?
    var pingedAt: Date?
    var profileId: Int32?
    
    init(avatarUrl: String? = nil, isBlackListed: Bool? = nil,
         name: String?, phoneNumber: String?,
         pingedAt: Date? = nil, profileId: Int32? = nil) {
        
        self.avatarUrl = avatarUrl
        self.isBlackListed = isBlackListed
        self.name = name
        self.phoneNumber = phoneNumber
        self.pingedAt = pingedAt
        self.profileId = profileId
    }
}

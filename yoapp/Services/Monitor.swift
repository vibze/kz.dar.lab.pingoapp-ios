//
//  Monitor.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/30/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore

struct Monitor {
    static var contactsMonitor: ListMonitor<Contact> = {
        let monitor = CoreStore.monitorList(From<Contact>().orderBy(.ascending(\.name)))
        return monitor
    }()
    
    static var registeredContactsMonitor: ListMonitor<Contact> = {
        let monitor = CoreStore.monitorList(From<Contact>().orderBy(.ascending(\.name)).where(\.profileId != 0))
        return monitor
    }()
    
    static var recentlyActiveMonitor: ListMonitor<Contact> = {
        let monitor = CoreStore.monitorList(From<Contact>().orderBy(.ascending(\.pingedAt)).where(\.profileId != 0))
        return monitor
    }()
    
    static var blackListMonitor: ListMonitor<Contact> = {
        let monitor = CoreStore.monitorList(From<Contact>().orderBy(.ascending(\.name))
                                                                    .where(\.isBlacklisted == true))
        return monitor
    }()
    
    static var favoriteWordsMonitor: ListMonitor<FavoriteWords> = {
        let monitor = CoreStore.monitorList(From<FavoriteWords>().orderBy(.descending(\.index)))
        return monitor
    }()
    
   
    static var profileDataMonitor : ListMonitor<Contact> = {
        let phoneNumber = Profile.current()?.phoneNumber
        print(phoneNumber)
        let monitor = CoreStore.monitorList(From<Contact>().where(\.phoneNumber == phoneNumber))
        return monitor
    }()
}

//
//  BlackListModel.swift
//  yoapp
//
//  Created by Kamila Kusainova on 05.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore

class BlackListModel {
    var avatarUrl: String?
    var name: String?
    var phoneNumber: String?
    var profileId: Int32?
   
    static func fetchBlackListContactFromCore(completionHandler: @escaping([Contact]) -> ()){
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            let contactsArray = transaction.fetchAll(From<Contact>()
                                      .orderBy(.ascending(\.name))
                                      .where(\.profileId != 0))
//                                      .where(\.isBlacklisted == true))
            
            completionHandler(contactsArray!)
        }, completion: {(result) -> Void in   })
    }
}

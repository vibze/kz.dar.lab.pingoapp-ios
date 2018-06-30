//
//  Store.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/26/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import CoreStore
import Contacts

class Store {

    static func initCoreStore() {
        CoreStore.defaultStack = DataStack (
            xcodeModelName: "app",
            bundle: Bundle.main,
            migrationChain: []
        )
        do {
            try CoreStore.addStorageAndWait()
        }
        catch let error {
            print(error)
        }
    }
    
    // Clean core store
    static func cleanCoreStore() {
        CoreStore.perform(
            asynchronous: {
                $0.deleteAll(From<Contact>())
            },
            completion: { (result) -> Void in
                switch result {
                case .success: print("success!")
                case .failure(let error): print(error)
                }
            }
        )
    }
}

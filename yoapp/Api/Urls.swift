//
//  Urls.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/28/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

struct Urls {
    static let base: String = "http://178.62.123.161/api/v1/"

    static func getUrl(_ tail: Tail) -> String {
        switch tail {
        case .buddies:
            return base + "buddies"
        case .register_device_token:
            return base + "register_device_token"
        }
    }
}

enum Tail {
    case buddies, register_device_token
}

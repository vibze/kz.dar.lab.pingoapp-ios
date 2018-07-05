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
    static let baseUrl: String = "http://178.62.123.161"
    
    static func getUrl(_ tail: Tail) -> String {
        switch tail {
        case .buddies:
            return base + "buddies"
        }
    }
}

enum Tail {
    case buddies
}

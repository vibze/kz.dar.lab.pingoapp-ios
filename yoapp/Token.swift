//
//  Token.swift
//  yoapp
//
//  Created by Arthur Belyankov on 04.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import AccountKit

class Token {
    var accessToken: String? = nil
    var deviceToken: String? = nil
    static let shared = Token()
}

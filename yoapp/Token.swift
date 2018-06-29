//
//  Token.swift
//  yoapp
//
//  Created by Kamila Kusainova on 28.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import AccountKit

class Token {
    var accessToken: AKFAccessToken? = nil

    static let shared = Token()
}

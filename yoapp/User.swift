//
//  User.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/20/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    var name: String
    var email: String
    var password: String
    
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
        
    }
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        self.init(name: name, email: email, password: password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
    }
}

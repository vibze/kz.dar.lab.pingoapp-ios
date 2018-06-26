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
    var url: String
    var password: String
    
    init(name: String, url: String, password: String) {
        self.name = name
        self.url = url
        self.password = password
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let url = aDecoder.decodeObject(forKey: "url") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        self.init(name: name, url: url, password: password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(url, forKey: "url")
        aCoder.encode(password, forKey: "password")
    }
    
    static func current() -> User? {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "user") as? Data
        var user: User?
        if let decoded = decoded {
            user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? User
        }
        return user
    }
    
    static func addToUserDefaults(_ user: User) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: "user")
        userDefaults.synchronize()
    }
}

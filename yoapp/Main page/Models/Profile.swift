//
//  Profile.swift
//  yoapp
//
//  Created by Arthur Belyankov on 26.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding  {
    
    var phoneNumber: String
    var avatarImageUrl: String
    
    init (phoneNumber: String, avatarImageUrl: String){
        self.phoneNumber = phoneNumber
        self.avatarImageUrl = avatarImageUrl
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(avatarImageUrl, forKey: "avatarImageUrl")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        let avatarImageUrl = aDecoder.decodeObject(forKey: "avatarImageUrl") as! String
        self.init(phoneNumber: phoneNumber, avatarImageUrl: avatarImageUrl)
    }
    
    static func current() -> Profile? {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "user") as? Data
        var user: Profile? 
        if let decoded = decoded {
            user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Profile
        }
        return user
    }
    
    static func addToUserDefaults(_ user: Profile) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: "user")
        userDefaults.synchronize()
    }

}

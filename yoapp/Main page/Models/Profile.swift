//
//  Profile.swift
//  yoapp
//
//  Created by Arthur Belyankov on 26.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding  {
    
    var phoneNumber: String = ""
    var avatarImageUrl: String = ""
    var authorizationToken: String = ""
    
    init (phoneNumber: String?, avatarImageUrl: String?, authorizationToken: String?){
        self.phoneNumber = phoneNumber ?? ""
        self.avatarImageUrl = avatarImageUrl ?? ""
        self.authorizationToken = authorizationToken ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(avatarImageUrl, forKey: "avatarImageUrl")
        aCoder.encode(authorizationToken, forKey: "authorizationToken")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String
        let avatarImageUrl = aDecoder.decodeObject(forKey: "avatarImageUrl") as? String
        let authorizationToken = aDecoder.decodeObject(forKey: "authorizationToken") as? String
        self.init(phoneNumber: phoneNumber, avatarImageUrl: avatarImageUrl, authorizationToken: authorizationToken)
    }
    
    static func current() -> Profile? {
        if let decoded = UserDefaults.standard.object(forKey: "CurrentProfile") as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Profile
        }
        return nil
    }
    
    static func addToUserDefaults(_ user: Profile) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: "CurrentProfile")
        userDefaults.synchronize()
    }

}

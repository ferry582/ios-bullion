//
//  UserDefaultsHelper.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import Foundation

struct UserDefaultsHelper {
    enum Keys: String {
        case currentEmail = "current-email"
        case currentName = "current-name"
        
        var key: String {
            self.rawValue
        }
    }
    
    static func saveValue(value: Any, key: Keys) {
        UserDefaults.standard.set(value, forKey: key.key)
    }
    
    static func retrieveValue<T>(key: Keys, type: T.Type) -> T? {
        UserDefaults.standard.object(forKey: key.key) as? T
    }

    static func removeValue(key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.key)
    }
}

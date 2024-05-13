//
//  UserDefaultsManager.swift
//  BornGazette
//
//  Created by Rafael Melo on 13/05/24.
//

import Foundation

enum UserDefaultsKeys: String {
    case readLaterList
}

class UserDefaultsManager {
    
    public static var shared = UserDefaultsManager()
    var userDefaults = UserDefaults.standard
    var readLaterList = [String:Dictionary<String, String>]()

    func addToReadLater(_ article: [String:Dictionary<String, String>]) {
        readLaterList = userDefaults.object(forKey: UserDefaultsKeys.readLaterList.rawValue) as? [String:Dictionary<String, String>] ?? [:]
        for item in article {
            readLaterList["\(item.key)"] = item.value
        }
        
        userDefaults.set(readLaterList, forKey: UserDefaultsKeys.readLaterList.rawValue)
        userDefaults.synchronize()
    }
    
    func removeFromReadLater(_ article: [String:Dictionary<String, String>]) {
        readLaterList = userDefaults.object(forKey: UserDefaultsKeys.readLaterList.rawValue) as? [String:Dictionary<String, String>] ?? [:]
        guard let id = article.first?.key else {return}
        readLaterList.removeValue(forKey: id)
        userDefaults.set(readLaterList, forKey: UserDefaultsKeys.readLaterList.rawValue)
        userDefaults.synchronize()
    }
}

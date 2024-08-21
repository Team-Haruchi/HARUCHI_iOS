//
//  UserDefaultManager.swift
//  HARUCHI
//
//  Created by 이건우 on 8/20/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}

    private enum UserDefaultKeys: String {
        case isLoggedIn
    }

    // MARK: - Setters
    func setLoggedIn(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    // MARK: - Getters
    func checkLoginStatus() -> Bool {
        return defaults.bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    // MARK: - Clear Data
    func clearUserData() {
        defaults.removeObject(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
}

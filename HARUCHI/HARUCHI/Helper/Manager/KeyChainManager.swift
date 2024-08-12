//
//  KeyChain.swift
//  HARUCHI
//
//  Created by 이건우 on 8/12/24.
//

import Foundation
import Security

final class KeyChainManager {
    static func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,   // 저장할 Key
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any   // 저장할 Data
        ]
        SecItemDelete(query) // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    static func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오도록
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    static func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}

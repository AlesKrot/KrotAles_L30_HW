//
//  CredentialsKeychainStorage.swift
//  KrotAles_L30_HW
//
//  Created by Ales Krot on 2.02.22.
//

import Foundation
import Security

class CredentialsKeychainStorage {
    func save(login: String, password: String, domain: String) -> Bool {
        let passwordData = password.data(using: .utf8)

        let keychainItem = [kSecClass: kSecClassInternetPassword,
                      kSecAttrAccount: login,
                        kSecValueData: passwordData as Any,
                       kSecAttrServer: domain] as CFDictionary
        let status = SecItemAdd(keychainItem, nil)
        return status == 0
    }
    
    private static func update(login: String, password: String, domain: String) -> Bool {
        guard let data = password.data(using: .utf8) else { return false }
        let query = [kSecClass: kSecClassInternetPassword,
                     kSecAttrServer: domain] as CFDictionary
        
        let updateFields = [kSecValueData: data,
                          kSecAttrAccount: login] as CFDictionary
        let status = SecItemUpdate(query, updateFields)
        return status == 0
    }
    
    func getCredentials(for domain: String) -> (String, String)? {
        let query = [kSecClass: kSecClassInternetPassword,
                     kSecAttrServer: domain,
                     kSecReturnAttributes: true,
                     kSecReturnData: true] as CFDictionary
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        guard let result = result as? NSDictionary,
              let data = result[kSecValueData] as? Data,
              let password = String(data: data, encoding: .utf8),
              let login = result[kSecAttrAccount] as? String else { return nil }
        
        return (login, password)
    }
    
    func remove(for domain: String) -> Bool {
        let query = [kSecClass: kSecClassInternetPassword,
                     kSecAttrServer: domain] as CFDictionary
        
        let status = SecItemDelete(query)
        return status == 0
    }
    
    func check(for domain: String) -> String? {
        let query = [kSecClass: kSecClassInternetPassword,
                     kSecAttrServer: domain,
                     kSecReturnAttributes: true,
                     kSecReturnData: true] as CFDictionary
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        guard let result = result as? NSDictionary,
              let token = result[kSecAttrTokenID] as? String else { return nil }
        
        return token
    }
}

//
//  KeychainHelper.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import Foundation

enum KeychainError: LocalizedError {
    case itemNotFound
    case duplicateItem
    case unexpectedStatus(OSStatus)
}

class KeychainHelper {
    static let standard = KeychainHelper()
    let tokenService = "token-service"
    
    func insertToken(_ token: Data, identifier: String, service: String = standard.tokenService) throws {
        let attributes = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: identifier,
            kSecValueData: token
        ] as CFDictionary

        let status = SecItemAdd(attributes, nil)
        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                throw KeychainError.duplicateItem
            }
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func getToken(identifier: String, service: String = standard.tokenService) throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: identifier,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                throw KeychainError.itemNotFound
            }
            throw KeychainError.unexpectedStatus(status)
        }
        return String(data: result as! Data, encoding: .utf8)!
    }
    
    func updateToken(_ token: Data, identifier: String, service: String = standard.tokenService) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: identifier
        ] as CFDictionary

        let attributes = [
            kSecValueData: token
        ] as CFDictionary

        let status = SecItemUpdate(query, attributes)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                throw KeychainError.itemNotFound
            }
            throw KeychainError.unexpectedStatus(status)
        }
    }

    func upsertToken(_ token: Data, identifier: String, service: String = standard.tokenService) throws {
        do {
            _ = try getToken(identifier: identifier, service: service)
            try updateToken(token, identifier: identifier, service: service)
        } catch KeychainError.itemNotFound {
            try insertToken(token, identifier: identifier, service: service)
        }
    }
    
    func deleteToken(identifier: String, service: String = standard.tokenService) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: identifier
        ] as CFDictionary

        let status = SecItemDelete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}

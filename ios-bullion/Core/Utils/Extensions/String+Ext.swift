//
//  String+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import Foundation
import CryptoKit

extension String {
    func sha256() -> String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}

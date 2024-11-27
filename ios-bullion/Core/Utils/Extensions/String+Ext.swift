//
//  String+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import Foundation
import CryptoKit
import UIKit

extension String {
    func sha256() -> String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    func toDateFromISO() -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.date(from: self)
    }
    
    func getImageFromString() -> UIImage? {
        let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        return imageData == nil ? nil : UIImage(data: imageData!)
    }
    
    func getFirstAndLastName() -> (firstName: String?, lastName: String?) {
        let nameComponents = self.split(separator: " ").map { String($0) }
        guard nameComponents.count >= 2 else {
            return (firstName: nameComponents.first, lastName: nil)
        }
        let firstName = nameComponents.first
        let lastName = nameComponents.dropFirst().joined(separator: " ")
        return (firstName: firstName, lastName: lastName)
    }
}

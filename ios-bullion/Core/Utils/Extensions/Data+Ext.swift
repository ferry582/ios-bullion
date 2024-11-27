//
//  Data+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 27/11/24.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

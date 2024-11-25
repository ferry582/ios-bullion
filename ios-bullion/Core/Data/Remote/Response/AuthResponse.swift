//
//  AuthResponse.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation

struct AuthResponse: Codable {
    let status: Int
    let iserror: Bool
    let message: String
    let data: User
}

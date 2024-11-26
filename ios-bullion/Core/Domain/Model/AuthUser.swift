//
//  AuthUser.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation

struct AuthUser: Codable {
    let name: String
    let email: String
    let token: String?
}

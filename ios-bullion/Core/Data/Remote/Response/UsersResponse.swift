//
//  UsersResponse.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation

struct UsersResponse: Codable {
    let data: [UserResponse]
}

struct UserResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dob = "date_of_birth"
        case name, gender, email, photo, phone, address
    }
    
    let id, name, gender, dob, email, photo, phone, address: String
}

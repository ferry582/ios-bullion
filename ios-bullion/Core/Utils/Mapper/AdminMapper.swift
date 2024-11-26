//
//  AdminMapper.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import UIKit

struct AdminMapper {
    static func mapUsersResponseToDomain(input response: [UserResponse]) -> [User] {
        return response.map { result in
            return User(
                id: result.id,
                name: result.name ?? "-",
                gender: Gender(rawValue: result.gender) ?? .male,
                dob: result.dob.toDateFromISO() ?? .now,
                email: result.email,
                photo: result.photo.getImageFromString(),
                phone: result.phone,
                address: result.address
            )
        }
    }
    
    static func transformUserResponseToDomain(input response: UserResponse) -> User {
        let name: String = if let name = response.name {
            name
        } else {
            (response.firstName ?? "") + " " + (response.lastName ?? "")
        }
        return User(
            id: response.id,
            name: name,
            gender: Gender(rawValue: response.gender) ?? .male,
            dob: response.dob.toDateFromISO() ?? .now,
            email: response.email,
            photo: response.photo.getImageFromString(),
            phone: response.phone,
            address: response.address
        )
    }
}

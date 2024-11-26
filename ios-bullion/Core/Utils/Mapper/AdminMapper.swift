//
//  AdminMapper.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import UIKit

struct AdminMapper {
    static func mapUserResponsesToDomains(input adminResponses: [UserResponse]) -> [User] {
        return adminResponses.map { result in
            return User(
                id: result.id,
                name: result.name,
                gender: Gender(rawValue: result.gender) ?? .male,
                dob: result.dob.toDateFromISO() ?? .now,
                email: result.email,
                photo: result.photo.getImageFromString(),
                phone: result.phone,
                address: result.address
            )
        }
    }
    
}

//
//  AdminAPI.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation

enum AdminAPI {
    case users(offset: Int, limit: Int)
    case user(id: String)
    case update(user: User)
}

extension AdminAPI: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api-test.bullionecosystem.com"
    }
    
    var path: String {
        switch self {
        case .users:
            return "/api/v1/admin"
        case .user(let id):
            return "/api/v1/admin/\(id)"
        case .update(let user):
            return "/api/v1/admin/\(user.id)/update"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .users(let offset, let limit):
            return [
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
        default:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .users:
            return "get"
        case .user:
            return "get"
        case .update:
            return "put"
        }
    }
    
    var body: Data? {
        switch self {
        case .update(let user):
            let (firstName, lastName) = user.name.getFirstAndLastName()
            let json: [String: String] = [
                "first_name": firstName!,
                "last_name": lastName ?? firstName!,
                "gender": user.gender!.rawValue,
                "date_of_birth": user.dob!.toISO8601String(),
                "email": user.email,
                "phone": user.phone,
                "address": user.address
            ]
            return try? JSONSerialization.data(withJSONObject: json)
        default:
            return nil
        }
    }
    
    func generateURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let currentEmail = UserDefaultsHelper.retrieveValue(key: .currentEmail, type: String.self),
           let token = try? KeychainHelper.standard.getToken(identifier: currentEmail) {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            return request
        }
        
        return nil
    }
}

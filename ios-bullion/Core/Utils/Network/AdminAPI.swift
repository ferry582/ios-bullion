//
//  AdminAPI.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation

enum AdminAPI {
    case users(offset: Int, limit: Int)
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
        case .users(let offset, let limit):
            return "/api/v1/admin"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .users(let offset, let limit):
            return [
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
        }
    }
    
    var method: String {
        switch self {
        case .users(let offset, let limit):
            return "get"
        }
    }
    
    var body: Data? {
        switch self {
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

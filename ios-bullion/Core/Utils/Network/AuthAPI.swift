//
//  AuthAPI.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import Foundation

enum AuthAPI {
    case login(email: String, password: String)
}

extension AuthAPI: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api-test.bullionecosystem.com"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/v1/auth/login"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return "post"
    }
    
    var body: Data? {
        switch self {
        case .login(let email, let password):
            let json = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: json)
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
        return request
    }
}

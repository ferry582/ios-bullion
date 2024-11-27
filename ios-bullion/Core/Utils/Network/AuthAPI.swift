//
//  AuthAPI.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import Foundation

enum AuthAPI {
    case login(email: String, password: String)
    case register(user: User, password: String, imageData: Data, boundary: String = "Boundary-\(UUID().uuidString)")
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
        case .register:
            return "/api/v1/auth/register"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: String {
        return "post"
    }
    
    var headers: [String: String] {
        switch self {
        case .register(_, _, _, let boundary):
            return ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let email, let password):
            let json = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: json)
        case .register(let user, let password, let imageData, let boundary):
            var body = Data()
            let clrf = "\r\n"
            let (firstName, lastName) = user.name.getFirstAndLastName()
            
            let json: [String: String] = [
                "first_name": firstName!,
                "last_name": lastName ?? firstName!,
                "gender": user.gender!.rawValue,
                "date_of_birth": user.dob!.toISO8601String(),
                "email": user.email,
                "phone": user.phone,
                "address": user.address,
                "password": password.sha256()
            ]
            
            for (key, value) in json {
                body.append("--\(boundary)\(clrf)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(clrf)\(clrf)")
                body.append("\(value)\(clrf)")
            }
            
            body.append("--\(boundary)\(clrf)")
            body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\(clrf)")
            body.append("Content-Type: image/jpeg\(clrf)\(clrf)")
            body.append(imageData)
            body.append(clrf)

            body.append("--\(boundary)--\(clrf)")
            return body
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

        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}

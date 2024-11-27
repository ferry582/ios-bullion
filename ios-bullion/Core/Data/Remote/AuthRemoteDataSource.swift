//
//  AuthDataSource.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation
import Combine

protocol AuthRemoteDataSource {
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error>
    func register(user: User, password: String, imageData: Data) -> AnyPublisher<AuthResponse, Error>
}

struct AuthRemoteDataSourceImpl {
    static let shared: AuthRemoteDataSource = AuthRemoteDataSourceImpl()
}

extension AuthRemoteDataSourceImpl: AuthRemoteDataSource {
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, any Error> {
        return APIService.makeRequest(for: AuthAPI.login(email: email, password: password))
    }
    
    func register(user: User, password: String, imageData: Data) -> AnyPublisher<AuthResponse, any Error> {
        return APIService.makeRequest(for: AuthAPI.register(user: user, password: password, imageData: imageData))
    }
}

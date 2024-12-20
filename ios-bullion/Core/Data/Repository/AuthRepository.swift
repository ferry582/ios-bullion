//
//  AuthRepositoryImpl.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation
import Combine

protocol AuthRepository {
    func login(email: String, password: String) -> AnyPublisher<AuthUser, Error>
    func register(user: User, password: String, imageData: Data) -> AnyPublisher<AuthUser, Error>
}

struct AuthRepositoryImpl {
    private let dataSource: AuthRemoteDataSource
    static let shared: (AuthRemoteDataSource) -> AuthRepository = { dataSource in
        return AuthRepositoryImpl(dataSource: dataSource)
    }
}

extension AuthRepositoryImpl: AuthRepository {
    func login(email: String, password: String) -> AnyPublisher<AuthUser, any Error> {
        return dataSource.login(email: email, password: password)
            .map { response in
                return response.data
            }
            .eraseToAnyPublisher()
    }
    
    func register(user: User, password: String, imageData: Data) -> AnyPublisher<AuthUser, any Error> {
        return dataSource.register(user: user, password: password, imageData: imageData)
            .map { response in
                return response.data
            }
            .eraseToAnyPublisher()
    }
}

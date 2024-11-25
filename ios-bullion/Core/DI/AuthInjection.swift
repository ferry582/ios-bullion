//
//  AuthInjection.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation

struct AuthInjection {
    private static func provideRepository() -> AuthRepository {
        let dataSource = AuthRemoteDataSourceImpl.shared
        return AuthRepositoryImpl.shared(dataSource)
    }
    
    static func provideLoginUseCase() -> LoginUseCase {
        let repository = provideRepository()
        return LoginUseCaseImpl(repository: repository)
    }
}

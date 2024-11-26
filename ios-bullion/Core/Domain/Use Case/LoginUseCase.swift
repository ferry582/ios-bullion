//
//  LoginUseCase.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation
import Combine

protocol LoginUseCase {
    func executeLogin(email: String, password: String) -> AnyPublisher<AuthUser, Error>
}

struct LoginUseCaseImpl {
    let repository: AuthRepository
}

extension LoginUseCaseImpl: LoginUseCase {
    func executeLogin(email: String, password: String) -> AnyPublisher<AuthUser, any Error> {
        return repository.login(email: email, password: password)
    }
}

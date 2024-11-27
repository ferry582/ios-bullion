//
//  RegisterUseCase.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation
import Combine

protocol RegisterUseCase {
    func executeRegister(user: User, password: String, imageData: Data) -> AnyPublisher<AuthUser, Error>
}

struct RegisterUseCaseImpl {
    let repository: AuthRepository
}

extension RegisterUseCaseImpl: RegisterUseCase {
    func executeRegister(user: User, password: String, imageData: Data) -> AnyPublisher<AuthUser, any Error> {
        return repository.register(user: user, password: password, imageData: imageData)
    }
}

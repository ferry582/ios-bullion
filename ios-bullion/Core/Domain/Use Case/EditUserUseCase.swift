//
//  EditUserUseCase.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 27/11/24.
//

import Foundation
import Combine

protocol EditUserUseCase {
    func executeUpdate(user: User) -> AnyPublisher<(message: String, isError: Bool), Error>
}

struct EditUserUseCaseImpl {
    let repository: AdminRepository
}

extension EditUserUseCaseImpl: EditUserUseCase {
    func executeUpdate(user: User) -> AnyPublisher<(message: String, isError: Bool), any Error> {
        return repository.updateUser(user: user)
    }
}

//
//  HomeUseCase.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<[User], Error>
}

struct HomeUseCaseImpl {
    let repository: AdminRepository
}

extension HomeUseCaseImpl: HomeUseCase {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<[User], any Error> {
        return repository.getUsers(offset: offset, limit: limit)
    }
}

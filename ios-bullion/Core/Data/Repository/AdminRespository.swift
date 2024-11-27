//
//  AdminRespository.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation
import Combine
import UIKit

protocol AdminRepository {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<[User], Error>
    func getUser(id: String) -> AnyPublisher<User, Error>
    func updateUser(user: User) -> AnyPublisher<(message: String, isError: Bool), Error>
}

struct AdminRepositoryImpl {
    private let dataSource: AdminRemoteDataSource
    static let shared: (AdminRemoteDataSource) -> AdminRepository = { dataSource in
        return AdminRepositoryImpl(dataSource: dataSource)
    }
}

extension AdminRepositoryImpl: AdminRepository {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<[User], any Error> {
        return dataSource.getUsers(offset: offset, limit: limit)
            .map { response in
                AdminMapper.mapUsersResponseToDomain(input: response.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getUser(id: String) -> AnyPublisher<User, any Error> {
        return dataSource.getUser(id: id)
            .map { response in
                AdminMapper.transformUserResponseToDomain(input: response.data)
            }
            .eraseToAnyPublisher()
    }
    
    func updateUser(user: User) -> AnyPublisher<(message: String, isError: Bool), any Error> {
        return dataSource.updateUser(user: user)
            .map { response in
                return (response.message, response.iserror)
            }
            .eraseToAnyPublisher()
    }
}

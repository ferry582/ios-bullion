//
//  AdminRemoteDataSource.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation
import Combine

protocol AdminRemoteDataSource {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<UsersResponse, Error>
    func getUser(id: String) -> AnyPublisher<UserDetailResponse, Error>
    func updateUser(user: User) -> AnyPublisher<UserDetailResponse, Error>
}

struct AdminRemoteDataSourceImpl {
    static let shared: AdminRemoteDataSource = AdminRemoteDataSourceImpl()
}

extension AdminRemoteDataSourceImpl: AdminRemoteDataSource {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<UsersResponse, any Error> {
        return APIService.makeRequest(for: AdminAPI.users(offset: offset, limit: limit))
    }
    
    func getUser(id: String) -> AnyPublisher<UserDetailResponse, any Error> {
        return APIService.makeRequest(for: AdminAPI.user(id: id))
    }
    
    func updateUser(user: User) -> AnyPublisher<UserDetailResponse, any Error> {
        return APIService.makeRequest(for: AdminAPI.update(user: user))
    }
}

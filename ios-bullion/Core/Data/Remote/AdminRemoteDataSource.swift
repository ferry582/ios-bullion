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
}

struct AdminRemoteDataSourceImpl {
    static let shared: AdminRemoteDataSource = AdminRemoteDataSourceImpl()
}

extension AdminRemoteDataSourceImpl: AdminRemoteDataSource {
    func getUsers(offset: Int, limit: Int) -> AnyPublisher<UsersResponse, any Error> {
        return APIService.makeRequest(for: AdminAPI.users(offset: offset, limit: limit))
    }
}

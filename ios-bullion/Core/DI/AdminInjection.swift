//
//  AdminInjection.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import Foundation

struct AdminInjection {
    private static func provideRepository() -> AdminRepository {
        let dataSource = AdminRemoteDataSourceImpl.shared
        return AdminRepositoryImpl.shared(dataSource)
    }
    
    static func provideHomeUseCase() -> HomeUseCase {
        let repository = provideRepository()
        return HomeUseCaseImpl(repository: repository)
    }
    
    static func provideEditUserUseCase() -> EditUserUseCase {
        let repository = provideRepository()
        return EditUserUseCaseImpl(repository: repository)
    }
}

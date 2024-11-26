//
//  HomeViewModel.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 23/11/24.
//

import Foundation
import Combine

class HomeViewModel {
    let useCase: HomeUseCase
    private var cancellables = Set<AnyCancellable>()
    private var isBottomReached = false
    private let usersLimit = 10
    private var currentOffset = 10
    
    private(set) var users = CurrentValueSubject<[User], Never>([])
    private(set) var userDetail = PassthroughSubject<User, Never>()
    private(set) var navigateToLogin = CurrentValueSubject<Bool, Never>(false)
    private(set) var isLoading = CurrentValueSubject<Bool, Never>(false)
    private(set) var alertMessage = PassthroughSubject<String, Never>()
    
    init(useCase: HomeUseCase = AdminInjection.provideHomeUseCase()) {
        self.useCase = useCase
    }
    
    func logout() {
        do {
            if let email = UserDefaultsHelper.retrieveValue(key: .currentEmail, type: String.self) {
                try KeychainHelper.standard.deleteToken(identifier: email)
                UserDefaultsHelper.removeValue(key: .currentEmail)
                UserDefaultsHelper.removeValue(key: .currentName)
                navigateToLogin.send(true)
            }
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func getUsers() {
        guard !isBottomReached else { return }
        isLoading.send(true)
        
        useCase.getUsers(offset: currentOffset, limit: usersLimit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error): self?.showErrorMessage(error: error)
                }
                self?.isLoading.send(false)
            } receiveValue: { [weak self] users in
                if users.isEmpty {
                    self?.isBottomReached = true
                } else {
                    let currentUsers = self?.users.value ?? []
                    self?.users.send(currentUsers + users)
                    self?.currentOffset += 10
                }
            }
            .store(in: &cancellables)
    }
    
    func reloadUsers() {
        users.send([])
        currentOffset = 10
        isBottomReached = false
    }
    
    func getUserDetail(id: String) {
        isLoading.send(true)
        
        useCase.getUser(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error): self?.showErrorMessage(error: error)
                }
                self?.isLoading.send(false)
            } receiveValue: { [weak self] user in
                self?.userDetail.send(user)
            }
            .store(in: &cancellables)
    }
    
    private func showErrorMessage(error: Error) {
        if let networkError = error as? NetworkError {
            alertMessage.send(networkError.description)
        } else {
            alertMessage.send("An unexpected error occurred")
        }
    }
}

//
//  LoginViewModel.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 21/11/24.
//

import Foundation
import Combine

class LoginViewModel {
    let useCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    private(set) var alertMessage = PassthroughSubject<String, Never>()
    private(set) var navigateToHome = CurrentValueSubject<Bool, Never>(false)
    private(set) var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    init(useCase: LoginUseCase = AuthInjection.provideLoginUseCase()) {
        self.useCase = useCase
    }
    
    func login(email: String, password: String) {
        isLoading.send(true)
        
        do {
            try Validator.validate(text: email, with: [.notEmpty(field: "Email"), .validEmail])
            try Validator.validate(text: password, with: [.notEmpty(field: "Password"), .validPasswordLength])
            
            useCase.executeLogin(email: email, password: password.sha256())
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        if let networkError = error as? NetworkError {
                            self?.alertMessage.send(networkError.description)
                        } else {
                            self?.alertMessage.send("An unexpected error occurred")
                        }
                    }
                    self?.isLoading.send(false)
                } receiveValue: { [weak self] user in
                    guard let self = self, let token = user.token else { return }
                    do {
                        try KeychainHelper.standard.upsertToken(Data(token.utf8), identifier: user.email)
                        UserDefaultsHelper.saveValue(value: user.email, key: .currentEmail)
                        UserDefaultsHelper.saveValue(value: user.name, key: .currentName)
                        self.navigateToHome.send(true)
                    } catch {
                        self.alertMessage.send("Failed to save user data: \(error.localizedDescription)")
                    }
                }
                .store(in: &cancellables)
        } catch let error as ValidationError {
            alertMessage.send(error.description)
            isLoading.send(false)
        } catch {
            alertMessage.send(error.localizedDescription)
            isLoading.send(false)
        }
    }
}

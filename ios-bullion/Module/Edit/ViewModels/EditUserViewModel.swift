//
//  EditUserViewModel.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation
import Combine

class EditUserViewModel {
    let useCase: EditUserUseCase
    private var cancellables = Set<AnyCancellable>()
    private(set) var alertMessage = PassthroughSubject<String, Never>()
    private(set) var isLoading = CurrentValueSubject<Bool, Never>(false)
    private(set) var dismissController = CurrentValueSubject<Bool, Never>(false)
    
    init(useCase: EditUserUseCase = AdminInjection.provideEditUserUseCase()) {
        self.useCase = useCase
    }
    
    func updateUser(user: User) {
        isLoading.send(true)
        
        do {
            try validateUpdate(user: user)
            useCase.executeUpdate(user: user)
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
                } receiveValue: { [weak self] result in
                    self?.alertMessage.send(result.message)
                    if !result.isError {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                            self?.dismissController.send(true)
                        }
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
    
    private func validateUpdate(user: User) throws {
        try Validator.validate(text: user.name, with: [.notEmpty(field: "Name")])
        
        guard let _ = user.gender else {
            throw ValidationError.notEmpty(field: "Gender")
        }
        
        guard let _ = user.dob else {
            throw ValidationError.notEmpty(field: "Date of Birth")
        }
        
        try Validator.validate(text: user.email, with: [.notEmpty(field: "Email"), .validEmail])
        try Validator.validate(text: user.phone, with: [.notEmpty(field: "Phone number")])
        try Validator.validate(text: user.address, with: [.notEmpty(field: "Address")])
    }
}

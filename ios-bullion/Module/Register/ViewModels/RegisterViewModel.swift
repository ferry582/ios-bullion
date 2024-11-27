//
//  RegisterViewModel.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 21/11/24.
//

import Foundation
import Combine
import UIKit

class RegisterViewModel {
    let useCase: RegisterUseCase
    private var cancellables = Set<AnyCancellable>()
    private(set) var isLoading = CurrentValueSubject<Bool, Never>(false)
    private(set) var alertMessage = PassthroughSubject<String, Never>()
    private(set) var dismissController = CurrentValueSubject<Bool, Never>(false)
    
    init(useCase: RegisterUseCase = AuthInjection.provideRegisterUseCase()) {
        self.useCase = useCase
    }
    
    func register(user: User, photo: UIImage?, password: String, confirmPassword: String) {
        isLoading.send(true)
        
        do {
            try validateRegister(user: user, password: password, confirmPassword: confirmPassword)
            
            guard let imageData = photo?.jpegData(compressionQuality: 0.8) else {
                isLoading.send(false)
                alertMessage.send("Error when compressing image")
                return
            }
            
            let maxSizeInBytes = 5 * 1024 * 1024
            guard imageData.count <= maxSizeInBytes else {
                isLoading.send(false)
                alertMessage.send("Image size exceeds 5 MB. Please choose a smaller image.")
                return
            }
            
            useCase.executeRegister(user: user, password: password, imageData: imageData)
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
                    self?.alertMessage.send("\(user.name) has been registered, with email: \(user.email)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                        self?.dismissController.send(true)
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
    
    private func validateRegister(user: User, password: String, confirmPassword: String) throws {
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
        
        guard let _ = user.photo else {
            throw ValidationError.notEmpty(field: "Photo")
        }
        
        try Validator.validate(text: password, with: [.validPassword])
        try Validator.validate(text: confirmPassword, with: [.validPassword])
        
        guard password == confirmPassword else {
            throw ValidationError.passwordNotMatch
        }
    }
}

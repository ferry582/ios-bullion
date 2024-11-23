//
//  LoginViewModel.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 21/11/24.
//

import Foundation
import Combine

class LoginViewModel {
    private(set) var alertMessage = PassthroughSubject<String, Never>()
    
    func login(email: String, password: String) {
        do {
            try Validator.validate(text: email, with: [.notEmpty(field: "Email"), .validEmail])
            try Validator.validate(text: password, with: [.notEmpty(field: "Password"), .validPasswordLength])
        } catch let error as ValidationError {
            alertMessage.send(error.description)
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
}

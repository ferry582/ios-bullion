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
    private(set) var navigateToHome = CurrentValueSubject<Bool, Never>(false)
    
    func login(email: String, password: String) {
        do {
            try Validator.validate(text: email, with: [.notEmpty(field: "Email"), .validEmail])
            try Validator.validate(text: password, with: [.notEmpty(field: "Password"), .validPasswordLength])
            
            let hashedPass = password.sha256()
            
            // success response
            let bearerToken = ""
            let name = ""
            try KeychainHelper.standard.upsertToken(Data(bearerToken.utf8), identifier: email)
            UserDefaultsHelper.saveValue(value: email, key: .currentEmail)
            UserDefaultsHelper.saveValue(value: name, key: .currentName)
            
            navigateToHome.send(true)
        } catch let error as ValidationError {
            alertMessage.send(error.description)
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
}

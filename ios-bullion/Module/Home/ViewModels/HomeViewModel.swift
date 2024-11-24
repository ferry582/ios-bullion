//
//  HomeViewModel.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 23/11/24.
//

import Foundation
import Combine

class HomeViewModel {
    private(set) var navigateToLogin = CurrentValueSubject<Bool, Never>(false)
    
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
}

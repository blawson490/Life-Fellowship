//
//  AuthViewModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/6/24.
//

import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: AuthUser?

    private var cancellables = Set<AnyCancellable>()

    init() {
        updateLoginStatus()
    }

    func login(email: String, password: String) {
        AuthenticationService.shared.loginUser(email: email, password: password) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.isLoggedIn = true
                    self?.currentUser = AuthenticationService.shared.retrieveAuthUser()
                } else {
                    self?.isLoggedIn = false
                    self?.currentUser = nil
                }
            }
        }
    }
    
    func register(name: String, email: String, password: String, passwordConfirm: String, completion: @escaping (Bool) -> Void) {
        AuthenticationService.shared.registerUser(name: name, email: email, password: password, passwordConfirm: passwordConfirm) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.isLoggedIn = true
                    self?.currentUser = AuthenticationService.shared.retrieveAuthUser()
                    completion(success)
                } else {
                    self?.isLoggedIn = false
                    self?.currentUser = nil
                    completion(false)
                }
            }
        }
    }

    

    func logout() {
        AuthenticationService.shared.logout()
        isLoggedIn = false
        currentUser = nil
    }

    private func updateLoginStatus() {
        isLoggedIn = AuthenticationService.shared.isLoggedIn()
        currentUser = AuthenticationService.shared.retrieveAuthUser()
    }
}

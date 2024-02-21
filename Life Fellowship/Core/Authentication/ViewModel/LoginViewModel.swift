//
//  LoginViewModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var email = ""
    @Published var password = ""
//    @Published var showError = false
//    @Published var error = ""
    
    @MainActor
    func login() async throws {
        isLoading = true
        try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
        isLoading = false
    }
    
    func isRegistrationDisabled() -> Bool {
//        if fullName.isEmpty {
//            error = "Full name required."
//            showError = true
//            return true
//        } else if email.isEmpty {
//            error = "Email required."
//            showError = true
//            return true
//        } else if !doPasswordsMatch() {
//            error = "Passwords do not match"
//            showError = true
//            return true
//        } else {
//            return false
//        }
        return false
    }
}

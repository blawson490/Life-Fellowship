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
        
        return false
    }
}

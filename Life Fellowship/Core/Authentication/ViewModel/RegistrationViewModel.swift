//
//  RegistrationViewModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    
    @MainActor
    func createUser() async throws {
        isLoading = true
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullName: fullName
        )
        isLoading = false
    }
    
    func isRegistrationDisabled() -> Bool {
        
        return false
    }
    
    private func doPasswordsMatch() -> Bool {
        return password == confirmedPassword
    }
}

//
//  AuthService.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/6/24.
//
import Foundation
import Security

class AuthenticationService {
    static let shared = AuthenticationService()
    
    var token: String?
    var authUser: AuthUser?
    
    init() {
        self.token = retrieveToken()
        self.authUser = retrieveAuthUser()
    }

    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://lifefellowship.lawsonserver.xyz/api/auth/login") else {
            completion(false)
            return
        }
        let body: [String: Any] = ["email": email, "password": password]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            self.handleAuthenticationResponse(data: data)
            completion(true)
        }
        task.resume()
    }

    func registerUser(name: String, email: String, password: String, passwordConfirm: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://lifefellowship.lawsonserver.xyz/api/auth/register") else {
            completion(false)
            return
        }
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "passwordConfirm": passwordConfirm
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            self.handleAuthenticationResponse(data: data)
            completion(true)
        }
        task.resume()
    }

    private func handleAuthenticationResponse(data: Data) {
        do {
            let response = try JSONDecoder().decode(AuthResponse.self, from: data)
            storeToken(response.token)
            storeAuthUser(response.record)
        } catch {
            print("Failed to decode or store token")
        }
    }

    func storeToken(_ token: String) {
        let tokenItem = [
            kSecValueData: token.data(using: .utf8)!,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userToken"
        ] as [String: Any]

        SecItemAdd(tokenItem as CFDictionary, nil)
    }

    func retrieveToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userToken",
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String: Any]

        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            if let retrievedData = dataTypeRef as? Data,
               let token = String(data: retrievedData, encoding: .utf8) {
                return token
            }
        }
        return nil
    }
    
    func storeAuthUser(_ user: AuthUser) {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: "authUser")
        } catch {
            print("Error encoding user data: \(error)")
        }
    }
    
    func retrieveAuthUser() -> AuthUser? {
        if let userData = UserDefaults.standard.data(forKey: "authUser") {
            do {
                let user = try JSONDecoder().decode(AuthUser.self, from: userData)
                return user
            } catch {
                print("Error decoding user data: \(error)")
            }
        }
        return nil
    }


    func logout() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userToken"
        ] as [String: Any]

        SecItemDelete(query as CFDictionary)
        UserDefaults.standard.removeObject(forKey: "authUser")
    }

    func isLoggedIn() -> Bool {
        return retrieveToken() != nil
    }
}

struct AuthResponse: Codable {
    var token: String
    var record: AuthUser
}

struct AuthUser: Codable {
    var avatar: String
    var id: String
    var created: String
    var email: String
    var emailVisibility: Bool
    var name: String
    var role: String
    var updated: String
    var username: String
    var verified: Bool
}


//
//  LoginView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/6/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    @State private var showPassword = false
    
    @State private var isLoading = false
    @State private var showHomeGuest = false
    
    var body: some View {
            VStack {
                    VStack(alignment: .leading) {
                        Image("LF Logo")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Life")
                        Text("Fellowship")
                    }
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 1000, height: 1000)
                            .offset(x: -50, y: 0)
                    }
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundStyle(.white)
                            .foregroundStyle(.primary)
                        
                        CustomTextField()
                    }
                    VStack(alignment: .leading) {
                        Text("Password")
                            .foregroundStyle(.white)
                        
                        CustomSecureField()
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Text("Forgot Password?")
                                    .foregroundStyle(.white)
                                    .font(.callout)
                                    .fontWeight(.medium)
                            })
                        }
                    }
                    Button(action: {
                        withAnimation {
                            isLoading = true
                        }
                        viewModel.login(email: email, password: password)
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Sign in")
                                .foregroundStyle(Color.black.opacity((password == "" || email == "" ? 0.5 : 1)))
//                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding()
                        .background(Color.white.opacity(password == "" || email == "" ? 0.5 : 1))
                        .cornerRadius(8)
                        .shadow(radius: 8, y: 2)
                        .padding(.vertical)
                        .overlay {
                            if password == "" && email == "" {
                                
                            }
                        }
                    })
                    .disabled(password == "" && email == "")
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                Spacer()
                
                VStack {
                    Text("Don't have an account?")
                        .fontWeight(.light)
                    NavigationLink(destination: {RegisterView()}, label: {
                        HStack {
                            Spacer()
                            Text("Sign up with email")
                                .foregroundStyle(Color.white)
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(8)
                        .shadow(radius: 8, y: 4)
                        .padding(.horizontal)
                    })
                    
                    HStack {
                        Text("Not ready to create an account?")
                        Button(action: {
                            showHomeGuest = true
                        }, label: {
                            Text("Continue as Guest")
                                .foregroundStyle(Color.accentColor)
                        })
                    }
                    .fontWeight(.light)
                    .font(.footnote)
                    .padding(.vertical)
                }
                .padding(.bottom)
            }
            .background(Color("AppBackground"))
            .overlay {
                if isLoading {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView()
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color("AppBackground")))
                            Spacer()
                        }
                        Spacer()
                    }
                    .background(.ultraThinMaterial)
                }
            }
            .fullScreenCover(isPresented: $showHomeGuest) {
                RootView()
            }
    }
    
    @ViewBuilder
    func CustomTextField() -> some View {
        HStack {
            TextField("Email", text: $email)
                .foregroundStyle(.white)
                .textInputAutocapitalization(TextInputAutocapitalization(.none))
                
        }
        .padding(14)
        .background(Color.black.cornerRadius(4).opacity(0.0).background(.ultraThinMaterial).cornerRadius(4))
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func CustomSecureField() -> some View {
        HStack(alignment: .center) {
            if showPassword {
                TextField("Password", text: $password)
                    .foregroundColor(.white)
                    .padding(.trailing, 60)
            } else {
                SecureField("Minimum 6 Characters", text: $password)
                    .foregroundColor(.white)
                    .padding(.trailing, 60)
                    .padding(.vertical, password.count >= 1 ? 1 : 0)
            }
            
            Button(action: {
                self.showPassword.toggle()
            }) {
                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor(password != "" ? .white : .black.opacity(0.5))
            }
            .padding(.trailing, 15)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(14)
        .background(Color.black.cornerRadius(4).opacity(0.0).background(.ultraThinMaterial).cornerRadius(4))
        .frame(maxWidth: .infinity)
    }
    
    func loginUser(email: String, password: String) {
        guard let url = URL(string: "https://lifefellowship.lawsonserver.xyz/api/auth/login") else { return }
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        print("body: ", body)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("request: ", request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data: ", dataString)
            }
        }
        task.resume()
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}

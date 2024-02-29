//
//  LoginView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var showHome = false
    @State private var isLoading = false
    
    @State private var isLoginDisabled = true
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("LF-app-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .textContentType(.password)
                        .modifier(TextFieldModifier())
                }
                
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing, 20)
                        .foregroundStyle(Color(uiColor: .label))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                }
                
                
                Button {
                    Task {
                        try await viewModel.login()
                    }
                } label: {
                    HStack {
                        Spacer()
                            Text("Login")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(UIColor.systemBackground))
                                .padding()
                        Spacer()
                    }
                    .background(Color.primary)
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                //.disabled(isLoginDisabled)
                .buttonStyle(.plain)
                
                NavigationLink {
                    ContentView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Continue as Guest")
                        .foregroundStyle(Color(uiColor: .label))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .foregroundStyle(Color.accentColor)
                }
                
                Spacer()
                Divider()
                NavigationLink {
                    RegistrationView()
                } label: {
                    HStack (spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.primary)
                    .font(.footnote)
                    
                }
                .padding(.vertical, 16)
            }
        }
        .overlay {
            if isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    LoginView()
}

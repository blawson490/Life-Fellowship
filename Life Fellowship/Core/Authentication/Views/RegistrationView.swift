//
//  RegistrationView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("LF-app-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your full name", text: $viewModel.fullName)
                    .textContentType(.name)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .modifier(TextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .textContentType(.password)
                    .modifier(TextFieldModifier())
                
                SecureField("Confirm your password", text: $viewModel.confirmedPassword)
                    .modifier(TextFieldModifier())
                
            }
            
            Button {
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                HStack {
                    Spacer()
                        Text("Create Account")
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
            .padding(.vertical)
            .disabled(viewModel.isRegistrationDisabled())
            .buttonStyle(.plain)
            
            Spacer()
            Divider()
            Button {
                dismiss()
            } label: {
                HStack (spacing: 3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .font(.footnote)
                
            }
            .padding(.vertical, 16)
        }
        .overlay {
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RegistrationView()
}

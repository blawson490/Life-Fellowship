//
//  RegistrationView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var isRegistrationDisabled = true
    
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
                TextField("Enter your full name", text: $fullName)
                    .textContentType(.name)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .modifier(TextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .textContentType(.password)
                    .modifier(TextFieldModifier())
                
                SecureField("Confirm your password", text: $confirmedPassword)
                    .modifier(TextFieldModifier())
                
            }
            
            Button {
                
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
            .disabled(isRegistrationDisabled)
            .buttonStyle(.plain)
            
            Spacer()
            Divider()
            Button {
                dismiss()
            } label: {
                HStack (spacing: 3){
                    Text("Don't have an account?")
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .font(.footnote)
                
            }
            .padding(.vertical, 16)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RegistrationView()
}

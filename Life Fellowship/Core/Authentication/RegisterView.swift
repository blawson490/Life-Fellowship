//
//  RegisterView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/6/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var retypedPassword = ""
    @State private var agreedToTerms = false
    
    @State private var showPassword = false
    @State private var passwordError = ""
    
    @State private var tOFAccepted = false
    @State private var isLoading = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.callout)
                        .foregroundStyle(Color(uiColor: .label))
                        .padding(12)
                        .background(
                            Circle()
                                .fill(Color("AppBackground"))
                        )
                        .padding([.horizontal, .bottom])
                })
                Spacer()
            }
            .background(Color.accentColor)
            .overlay {
                HStack {
                    Spacer()
                    Image("LF Logo")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.bottom)
                    Spacer()
                }
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading) {
                        Text("REGISTRATION")
                            .foregroundStyle(Color.accentColor)
                            .font(.subheadline)
                            .bold()
                        
                        Text("Create an account")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    
                        VStack(alignment: .leading) {
                            Text("Full Name")
                                .foregroundStyle(.secondary)
                            
                            HStack {
                                TextField("Enter your full name...", text: $fullName)
                                    .foregroundStyle(Color.accentColor)
                                    .textInputAutocapitalization(TextInputAutocapitalization(.none))
                                    
                            }
                            .padding(14)
                            .background(Color.black.cornerRadius(6).opacity(0.0).background(.ultraThinMaterial).cornerRadius(6))
                            .frame(maxWidth: .infinity)
                        }
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            TextField("Enter your email...", text: $email)
                                .foregroundStyle(Color.accentColor)
                                .textInputAutocapitalization(TextInputAutocapitalization(.none))
                                
                        }
                        .padding(14)
                        .background(Color.black.cornerRadius(6).opacity(0.0).background(.ultraThinMaterial).cornerRadius(6))
                        .frame(maxWidth: .infinity)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .foregroundStyle(.secondary)
                        
                        VStack(alignment: .leading) {
                            CustomSecureField(false)
                            
                            Text(passwordError)
                                .foregroundStyle(.red)
                                .font(.caption)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Retype Password")
                            .foregroundStyle(.secondary)
                        
                        VStack(alignment: .leading) {
                            CustomSecureField(true)
                            
                            Text(passwordError)
                                .foregroundStyle(.red)
                                .font(.caption)
                        }
                    }
                    
                    VStack {
                        HStack(alignment: .top) {
                            if tOFAccepted {
                                    Image(systemName: "checkmark.square.fill")
                                    .foregroundStyle(Color.accentColor)
                            } else {
                                Image(systemName: "square")
                            }
                            VStack(alignment: .leading) {
                                Text("Terms of Service")
                                    .fontWeight(.semibold)
                                
                                Text("I accept the terms and conditions of the Life Fellowship App as well as the privacy policy.")
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            tOFAccepted.toggle()
                        }
                    }
                    
                    Button(action: {
                        withAnimation {
                            isLoading = true
                        }
                        viewModel.register(name: fullName, email: email, password: password, passwordConfirm: retypedPassword) { success in
                            if success {
                                dismiss()
                            } else {
                                isLoading = false
                            }
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Register")
                                .foregroundStyle(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(8)
                        .shadow(radius: 8, y: 2)
                        .padding(.vertical)
                    })
//                    .disabled(password == "" || email == "" || fullName == "" || retypedPassword == "")
                    
                    VStack {
                        Text("Already have an account?")
                            .fontWeight(.light)
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Sign in with email")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.light)
                                Spacer()
                            }
                            .padding()
                            .background(Color("AuthAccent"))
                            .cornerRadius(8)
                            .shadow(radius: 8, y: 4)
                        })
                    }
                }
                .padding()
            }
            .background(Color("AppBackground"))
        }
        .navigationBarBackButtonHidden()
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
    }
    @ViewBuilder
    func CustomSecureField(_ toVerify: Bool) -> some View {
        HStack(alignment: .center) {
            if showPassword {
                TextField("Password", text: toVerify ? $retypedPassword : $password)
                    .foregroundStyle(.primary)
                    .padding(.trailing, 60)
            } else {
                SecureField("Minimum 6 Characters", text: toVerify ? $retypedPassword : $password)
                    .foregroundStyle(.primary)
                    .padding(.trailing, 60)
                    .padding(.vertical, password.count >= 1 ? 1 : 0)
            }
            
            Button(action: {
                self.showPassword.toggle()
            }) {
                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor(password != "" ? .primary : .black.opacity(0.5))
            }
            .padding(.trailing, 15)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(14)
        .background(Color.black.cornerRadius(4).opacity(0.0).background(.ultraThinMaterial).cornerRadius(4))
        .frame(maxWidth: .infinity)
    }

}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}

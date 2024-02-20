//
//  PremiumAccountView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/17/24.
//

import SwiftUI

struct PremiumAccountView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showPremium: Bool
//    @Binding var selection: Tab
    @State private var showAlert = false
    var body: some View {
        VStack {
            VStack {
                Text("Premium Features")
                    .font(.title2)
                    .bold()

                
                Text("Create an account today to unlock some amazing features and personalize your own content library!")
                    .padding()
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .padding(.top)
            
            VStack {
                Benefits(text: "Get involved in the community")
                Benefits(text: "RSVP for events")
                Benefits(text: "It's Free!")
            }
            .font(.callout)
            .padding()
            .padding(.horizontal)
            
            VStack {
                Button {
//                    showAlert = true
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Create Account")
                            .padding(6)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(uiColor: .tertiarySystemBackground))
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .alert("Coming Soon 🥳", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("This feature is under development and will be available soon.")
                }
                
                Button {
                    showPremium = false
                } label: {
                    HStack {
                        Spacer()
                        Text("Skip for now")
                            .padding(6)
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .padding(.vertical)
                
            }
            .padding()
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(uiColor: .secondarySystemBackground))
                .shadow(radius: 10)
                .padding()
        }
    }
    
@ViewBuilder
    func Benefits(text: String) -> some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Color.accentColor)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
//    PremiumAccountView(showPremium: .constant(true), selection: .constant(Tab.home))
    PremiumAccountView(showPremium: .constant(true))
}

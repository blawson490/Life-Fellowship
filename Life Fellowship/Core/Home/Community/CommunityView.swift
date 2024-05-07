//
//  CommunityView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Surround Yourself")
                .font(.title2.bold())
            Text("We all need friends - to encourage, inspire, challenge, and love us; and they need you too.")
            if viewModel.currentUser == nil {
                Text("Sign up to start adding friends today!")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    if viewModel.currentUser != nil {
                    } else {
                        dismiss()
                    }
                }, label: {
                    HStack {
                        Text(viewModel.currentUser != nil ? "Add Friends" : "Sign up")
                            .bold()
                            .foregroundStyle(Color.white)
                        
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(Color.accentColor))
                })
                Spacer()
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("CardBackground"))
        }
    }
}

#Preview {
    CommunityView()
        .environmentObject(AuthViewModel())
}

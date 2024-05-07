//
//  ContentView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            if viewModel.isLoggedIn {
                RootView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}

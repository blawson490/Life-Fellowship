//
//  RootView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

struct RootView: View {
    @State private var isUser = false
    var body: some View {
        VStack {
            if isUser {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView()
}

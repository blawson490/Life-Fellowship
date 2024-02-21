//
//  RootView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
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

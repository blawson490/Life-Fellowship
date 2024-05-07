//
//  Life_FellowshipApp.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

@main
struct Life_FellowshipApp: App {
    @StateObject private var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

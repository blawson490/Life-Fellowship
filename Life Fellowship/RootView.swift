//
//  RootView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI


enum Tab {
    case home
    case stream
    case thisweek
    case events
    case more
}

struct RootView: View {
    @State private var selection: Tab = .home
    var body: some View {
        TabView(selection: $selection) {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            
            Text("Stream")
                .navigationTitle("Stream")
                .navigationBarTitleDisplayMode(.large)
                .tabItem {
                    Label("Stream", systemImage: "play.circle")
                }
                .tag(Tab.stream)
            
            Text("This Week")
                .navigationTitle("This Week")
                .navigationBarTitleDisplayMode(.large)
                .tabItem {
                    Label("This Week", systemImage: "clock.badge")
                }
                .tag(Tab.thisweek)
            
            Text("Events")
                .navigationTitle("Events")
                .navigationBarTitleDisplayMode(.large)
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(Tab.events)
            
            Text("More")
                .navigationTitle("More")
                .navigationBarTitleDisplayMode(.large)
                .tabItem {
                    Label("More", systemImage: "line.3.horizontal")
                }
                .tag(Tab.more)
        }
    }
}


#Preview {
    RootView()
}

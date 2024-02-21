//
//  ContentView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

enum Tab {
    case home
    case watch
    case events
    case groups
    case library
    case messages
}

struct ContentView: View {
    @State private var selection: Tab = .home
    @State private var prevSelection: Tab = .home
    @State private var showPremium: Bool = false
//    @State private var showSplashscreen: Bool = false
    @State private var isLoading = true
    @State private var loadedVideos: [VideoItem] = []
    var body: some View {
        TabView(selection: $selection) {
            HomeView(videos: $loadedVideos, showPremium: $showPremium)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            
            SermonsView(videos: $loadedVideos)
                .tabItem {
                Label("Sermons", systemImage: "book")
            }
            .tag(Tab.watch)
            
            Text("Announcements Coming Soon! 🎉🥳")
                .onAppear {
                    showPremium = true
                }
                .tabItem {
                Label("Announcements", systemImage: "megaphone")
            }
            .tag(Tab.events)
            
            Text("Messages Coming Soon! 🎉🥳")
                .onAppear {
                    showPremium = true
                }
                .tabItem {
                Label("Messages", systemImage: "message")
            }
            .tag(Tab.messages)
            
            Text("Groups Coming Soon! 🎉🥳")
                .onAppear {
                    showPremium = true
                }
                .tabItem {
                Label("Groups", systemImage: "rectangle.3.group.bubble")
            }
            .tag(Tab.groups)
            
        }
//        .onChange(of: selection) { _, newValue in
//            if ![Tab.events, Tab.groups, Tab.library].contains(newValue) {
//                prevSelection = selection
//            }
//        }
//        .onChange(of: showPremium) {
//            if showPremium == false {
//                selection = prevSelection
//            }
//        }
        .overlay {
            
//            if showSplashscreen {
//                SplashScreen(showing: $showSplashscreen)
//            }
            
            if isLoading {
                LoadingView()
            }
            
            if showPremium {
                VStack {
                    Spacer()
                    PremiumAccountView(showPremium: $showPremium)
                    Spacer()
                }
                    .background {
                        Rectangle()
                            .fill(Color.black)
                            .opacity(0.75)
                    }
                    .edgesIgnoringSafeArea(.all)
                    
            }
        }
        .onAppear {
            isLoading = true
            VideoFeedLoader().loadVideos { loadedVideos in
                self.loadedVideos = loadedVideos
                self.isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}

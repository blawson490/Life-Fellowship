//
//  HomeView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Binding var videos: [VideoItem]
    @Binding var showPremium: Bool
    @State private var showAlert = false
    var announcements: [Announcement] = [
        Announcement(id: 1, title: "New Here?", description: "We want to connect with you.", imageName: "connect", isFeatured: true),
        Announcement(id: 2, title: "Newcomer Party", description: "Feb 18th at 6pm. RSVP in the Connection Center", imageName: "newcomer", isFeatured: true),
        Announcement(id: 3, title: "Girls Night", description: "K - 4th Girls. Friday, March 8th. 5 PM", imageName: "girlsnight", isFeatured: true),
        Announcement(id: 4, title: "Meal Team", description: "Join the Meal Team Today.", imageName: "mealteam", isFeatured: true),
        // Meal Team
        Announcement(id: 5, title: "Bible App", description: "Follow Life Fellowship in the Bible App.", imageName: "youversion", isFeatured: true),
        // You Version
        Announcement(id: 6, title: "Follow Us", description: "Follow us on social media.", imageName: "followus", isFeatured: true),
    ]
    
    var quickActions = [
        QuickAction(symbol: "star", color: Color.yellow, text: "I'm New", subText: "Welcome! Let's explore together."),
        QuickAction(symbol: "megaphone", color: Color.green, text: "Announcements", subText: "Tap here to hear about our latest news."),
        QuickAction(symbol: "hands.clap", color: Color.orange, text: "Prayer", subText: "Connecting through faith and prayer."),
        QuickAction(symbol: "gift", color: Color.mint, text: "Give", subText: "Support our mission with your generosity."),
        QuickAction(symbol: "questionmark", color: Color.indigo, text: "Requests", subText: "Assistance is just a request away."),
    ]
    
    var body: some View {
        NavigationView {
                ScrollView {
                    PageView(pages: announcements.map { AnnouncementCard(announcement: $0) })
                        .aspectRatio(16 / 9, contentMode: .fit)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(quickActions)  { action in
                                QuickActionView(quickAction: action)
                                    .padding(12)
                                    .padding(.leading, action == quickActions.first ? 8 : 0)
                                    .padding(.trailing, action == quickActions.last ? 8 : 0)
                            }
                        }
                        //                    .scrollTargetLayout()
                    }
                    //                .scrollTargetBehavior(.viewAligned)
                    
                    CountdownTimer()
                    
                    if !videos.isEmpty {
                        let video = videos[0]
                        RecentVideo(video: video)
                            .padding(.top)
                    }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Life Fellowship")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
//                    showAlert = true
                    showPremium = true
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .alert("Profile Coming Soon 🥳", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The Profile is currently under development and will be available soon.")
            }
        }
    }
}

//#Preview {
//    HomeView()
//}

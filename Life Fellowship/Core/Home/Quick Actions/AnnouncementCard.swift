//
//  AnnouncementCard.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct AnnouncementCard: View {
    var announcement: DummyAnnouncement
    var body: some View {
        announcement.featureImage?
            .resizable()
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay{
                TextOverlay(announcement: announcement)
            }
    }
}

struct TextOverlay: View {
    var announcement: DummyAnnouncement
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.8), .black.opacity(0)]),
                        startPoint: .bottom,
                        endPoint: .top)
    }
    var body: some View {
            ZStack(alignment: .bottomLeading) {
                gradient
                VStack(alignment: .leading) {
                    Text(announcement.title)
                        .font(.title)
                        .bold()
                    Text(announcement.description)
                }
                .padding()
            }
            .foregroundColor(.white)
        }
}

#Preview {
    AnnouncementCard(announcement: DummyAnnouncement(id: 1, title: "New Here?", description: "Use the connection card in the back of your seat!", imageName: "connect", isFeatured: true))
}

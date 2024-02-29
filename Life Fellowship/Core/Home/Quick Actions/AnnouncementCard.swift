//
//  AnnouncementCard.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct AnnouncementCard: View {
    var announcement: Announcement
    var body: some View {
        AsyncImage(url: announcement.image) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fill)
                     .clipShape(RoundedRectangle(cornerRadius: 8))
                     .shadow(radius: 8)
                     .overlay {
                         TextOverlay(announcement: announcement)
                     }
            case .empty:
                ProgressView()
            case .failure(_):
                Image(systemName: "photo")
//                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .aspectRatio(contentMode: .fit)
        .clipped()
    }
}

struct TextOverlay: View {
    var announcement: Announcement
    
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
                    Text(announcement.shortDescription)
                }
                .padding()
            }
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
}

//#Preview {
//    AnnouncementCard(announcement: DummyAnnouncement(id: 1, title: "New Here?", description: "Use the connection card in the back of your seat!", imageName: "connect", isFeatured: true))
//}

//
//  PageView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
//                .onChange(of: currentPage) { resetTimer() }
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                            .frame(width: CGFloat(pages.count * 18))
                            .padding(.trailing)
            
        }
        .onReceive(timer) { _ in
            withAnimation {
                currentPage = (currentPage + 1) % pages.count
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    private func resetTimer() {
        timer.upstream.connect().cancel()
        timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    PageView(pages: [
        Announcement(id: 1, title: "New Here?", description: "We want to connect with you.", imageName: "connect", isFeatured: true),
        Announcement(id: 2, title: "Follow Us", description: "Follow us on social media.", imageName: "followus", isFeatured: true),
        Announcement(id: 3, title: "Newcomer Party", description: "Feb 18th at 6pm. RSVP in the Connection Center", imageName: "newcomerparty", isFeatured: true)
    ].map { AnnouncementCard(announcement: $0) })
        .aspectRatio(16 / 9, contentMode: .fit)
}

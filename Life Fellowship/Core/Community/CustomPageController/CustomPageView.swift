//
//  CustomPageView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/23/24.
//

import SwiftUI

//struct CustomPageView<Page: View>: View {
//    var pages: [Page]
//    @State private var currentPage = 0
//    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
//    var body: some View {
//        VStack (alignment: .leading) {
//            CustomPageViewController(pages: pages, currentPage: $currentPage)
//            CustomPageControl(numberOfPages: pages.count, currentPage: $currentPage)
//                .frame(width: CGFloat(pages.count * 40))
//                .padding(.horizontal, 8)
//            
//        }
//        .onReceive(timer) { _ in
//            withAnimation {
//                currentPage = (currentPage + 1) % pages.count
//            }
//        }
//        .onDisappear {
//            timer.upstream.connect().cancel()
//        }
//    }
//}
//
//#Preview {
//    CustomPageView(pages: [
//        DummyAnnouncement(id: 1, title: "New Here?", description: "We want to connect with you.", imageName: "connect", isFeatured: true),
//        DummyAnnouncement(id: 2, title: "Follow Us", description: "Follow us on social media.", imageName: "followus", isFeatured: true),
//        DummyAnnouncement(id: 3, title: "Newcomer Party", description: "Feb 18th at 6pm. RSVP in the Connection Center", imageName: "newcomer", isFeatured: true)
//    ].map {
//        AnnouncementCard(announcement: $0)
//    })
//        .aspectRatio(16 / 9, contentMode: .fit)
//}

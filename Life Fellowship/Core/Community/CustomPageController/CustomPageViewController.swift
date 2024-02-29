//
//  CustomPageViewController.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/23/24.
//

import SwiftUI

//struct CustomPageViewController<Page: View>: View {
//    var pages: [Page]
//    @Binding var currentPage: Int
//    private let pageWidth: CGFloat = UIScreen.main.bounds.width
//    private let pagePeeking: CGFloat = 30 // Adjust for peeking amount
//    
//    @State private var offset = CGFloat.zero
//
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 0) {
//                    ForEach(0..<pages.count, id: \.self) { index in
//                        pages[index]
//                            .frame(width: geometry.size.width)
//                            .scaleEffect(scaleForPage(index))
//                            .offset(x: self.offsetForPage(index), y: 0)
//                            .animation(.easeOut, value: offset)
//                    }
//                }
//            }
//            .content.offset(x: offset)
//            .frame(width: geometry.size.width, alignment: .leading)
//            .gesture(
//                DragGesture().onChanged { value in
//                    offset = value.translation.width - geometry.size.width * CGFloat(currentPage)
//                }
//                .onEnded { value in
//                    let predictedEndOffset = value.predictedEndTranslation.width - geometry.size.width * CGFloat(currentPage)
//                    let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
//                    currentPage = max(0, min(pages.count - 1, predictedIndex))
//                    withAnimation {
//                        offset = -geometry.size.width * CGFloat(currentPage)
//                    }
//                }
//            )
//            .onAppear {
//                offset = -geometry.size.width * CGFloat(currentPage)
//            }
//        }
//    }
//    
//    private func scaleForPage(_ index: Int) -> CGFloat {
//        let pageOffset = CGFloat(index) * pageWidth
//        let delta = abs(offset + pageOffset)
//        if delta < pageWidth {
//            return 1 - (0.15 * (delta / pageWidth))
//        } else {
//            return 0.85
//        }
//    }
//    
//    private func offsetForPage(_ index: Int) -> CGFloat {
//        if index == currentPage {
//            return 0
//        } else if index < currentPage {
//            return -pagePeeking
//        } else {
//            return pagePeeking
//        }
//    }
//}
//
//
//#Preview {
//    CustomPageViewController(pages: [
//        DummyAnnouncement(id: 1, title: "New Here?", description: "We want to connect with you.", imageName: "connect", isFeatured: true),
//        DummyAnnouncement(id: 2, title: "Follow Us", description: "Follow us on social media.", imageName: "followus", isFeatured: true),
//        DummyAnnouncement(id: 3, title: "Newcomer Party", description: "Feb 18th at 6pm. RSVP in the Connection Center", imageName: "newcomer", isFeatured: true)
//    ].map { AnnouncementCard(announcement: $0) }, currentPage: .constant(1))
//}

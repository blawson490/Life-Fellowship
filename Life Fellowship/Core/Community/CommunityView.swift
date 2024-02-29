//
//  CommunityView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/22/24.
//

import SwiftUI

struct CommunityView: View {
    @ObservedObject private var viewModel = CommunityViewModel()
    @State private var searchText = ""
    @State private var showingAddNew = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if (viewModel.announcements.count > 1) {
                        PageView(pages: viewModel.announcements.map { AnnouncementCard(announcement: $0) })
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        
                        ForEach(viewModel.announcements) { announcement in
                            announcementItem(announcement: announcement)
                        }
                    } else {
                        Text("No announcements to display")
                    }
                    
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("Community")
            // TODO: Filter announcements based on search
//            .searchable(text: $searchText)
            .onAppear {
                viewModel.getAnnouncements()
            }
            .overlay {
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            LoadingView()
                            Spacer()
                        }
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .toolbar {
                if viewModel.CurrentUser?.type == "admin" {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingAddNew = true
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showingAddNew, content: {
                AddAnnouncement()
            })
        }
    }
    
    @ViewBuilder
    func announcementItem(announcement: Announcement) -> some View {
        HStack {
            AsyncImage(url: announcement.image) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 50, height: 50)
                         .clipShape(RoundedRectangle(cornerRadius: 8))
                         .shadow(radius: 8)
                case .empty:
                    ProgressView()
                case .failure(_):
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .aspectRatio(contentMode: .fit)
            .clipped()

            
            VStack (alignment: .leading) {
                Text(announcement.title)
                    .font(.headline)
                Text(announcement.shortDescription)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CommunityView()
}

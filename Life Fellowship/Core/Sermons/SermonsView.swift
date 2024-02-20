//
//  WatchView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct SermonsView: View {
    @Binding var videos: [VideoItem]
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            ScrollView {
                if !videos.isEmpty {
                    VStack (alignment: .leading) {
                        Text("New This Week")
                            .font(.headline)
                            .padding(.leading, 15)
                            .padding(.top, 5)
                        
                        NavigationLink(destination: VideoDetailsView(videoItem: videos[0])){
                            VStack {
                                ZStack {
                                    AsyncImage(url: videos[0].thumbnailURL) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    
                                    Image(systemName: "play.fill")
                                        .font(.title)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(
                                            Circle().fill(.ultraThinMaterial)
                                                .opacity(0.5))
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Text("NEW")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                                .padding(.vertical, 2)
                                                .padding(.horizontal, 6)
                                                .background(Capsule().fill(Color.accentColor))
                                        }
                                        .padding()
                                        Spacer()
                                    }
                                }
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(videos[0].title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text(videos[0].description)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.vertical, 8)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .background(Color(UIColor.systemBackground))
                            }
                            .cornerRadius(8)
                            .shadow(radius: 8)
                            .padding(.horizontal)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Up Next")
                        .font(.headline)
                        .padding([.top, .leading])
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Array(videos.enumerated()), id: \.element.id) { index, video in
                                if index != 0 {
                                    NavigationLink(destination: VideoDetailsView(videoItem: video)) {
                                        VideoPreview(video: video)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.leading, index == 1 ? 15 : 0)
                                    .padding(.trailing, video == videos.last ? 15 : 0)
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                }
            }
            .navigationTitle("Sermons")
        }
        .onAppear {
            VideoFeedLoader().loadVideos { loadedVideos in
                self.videos = loadedVideos
            }
        }
        .refreshable {
            VideoFeedLoader().refreshVideos { loadedVideos in
                self.videos = loadedVideos
            }
        }
    }
}

//Video Preview
struct VideoPreview: View {
    let video: VideoItem

    var body: some View {
        VStack (alignment: .leading) {
            ZStack {
                AsyncImage(url: video.thumbnailURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 112.5) // 16:9 aspect ratio
                .cornerRadius(8)
                .clipped()
                .shadow(radius: 4)
                
                Image(systemName: "play.fill")
                    .font(.body)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        Circle().fill(.ultraThinMaterial)
                            .opacity(0.8))
            }
            Text(video.title)
                .font(.headline)
                .lineLimit(1)

            Text(video.description)
                .font(.subheadline)
                .lineLimit(2)
        }
        .frame(width: 200)
    }
}

//#Preview {
//    SermonsView()
//}

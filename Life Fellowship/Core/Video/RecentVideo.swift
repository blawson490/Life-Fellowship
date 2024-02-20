//
//  RecentVideo.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct RecentVideo: View {
    var video: VideoItem?
    var body: some View {
        VStack (alignment: .leading) {
            Text("Recent Service")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            if let video {
                NavigationLink(destination: VideoDetailsView(videoItem: video)){
                    VStack {
                        ZStack {
                            AsyncImage(url: video.thumbnailURL) { image in
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
                                        .foregroundStyle(Color(uiColor: .label))
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 2)
                                        .padding(.horizontal, 6)
                                        .background(Capsule().fill(Color(uiColor: .tertiarySystemBackground)))
                                }
                                .padding()
                                Spacer()
                            }
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text(video.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(video.description)
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
                    .shadow(radius: 6)
                }
                .padding(.horizontal)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    RecentVideo()
}

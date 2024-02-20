//
//  VideoDetailsView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct VideoDetailsView: View {
    @State var videoItem: VideoItem?
    @State private var showingVideo = false
    @State private var showingAudio = false
    @State private var showAlert = false
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (spacing: 20) {
                if let videoItem {
                    Button {
                        showingVideo = true
                    } label: {
                            ZStack {
                                AsyncImage(url: videoItem.thumbnailURL) { image in
                                    image
                                        .resizable()
                                        .edgesIgnoringSafeArea(.top)
                                } placeholder: {
                                    ProgressView()
                                }
                                .aspectRatio(16 / 9, contentMode: .fit)
                                .clipped()
                                .shadow(radius: 6)
                                
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
                                .aspectRatio(16 / 9, contentMode: .fit)
                            }
                    }
                    VStack (alignment: .leading) {
                        VStack (alignment: .leading) {
                            Text(videoItem.title)
                                .font(.headline)
                            
                            Text(videoItem.pubDate)
                                .font(.caption)
                                .fontWeight(.light)
                                .fontDesign(.rounded)
                                .padding(.bottom)
                            
                            Text(videoItem.description)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Spacer()
                            Button {
                                showingVideo = true
                            } label: {
                                VStack {
                                    Image(systemName: "play.rectangle.on.rectangle.circle.fill")
                                    
                                        .font(.largeTitle)
                                    
                                    Text("Watch")
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            Spacer()
                            Button {
                                showingAudio = true
                            } label: {
                                VStack {
                                    Image(systemName: "waveform.circle.fill")
                                        .font(.largeTitle)
                                    
                                    Text("Listen")
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            Spacer()
                        }
                        .foregroundColor(.accentColor)
                        .padding(.top, 40)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(videoItem?.title ?? "Watch")
        .onAppear {
            // TODO: Remove for prod
            if videoItem == nil {
                VideoFeedLoader().loadVideos { loadedVideos in
                    if !loadedVideos.isEmpty {
                        self.videoItem = loadedVideos[5]
                    }
                }
            }
        }
        .alert("Coming Soon 🥳", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This feature is under development and will be available soon.")
        }
        .fullScreenCover(isPresented: $showingVideo, content: {
            if let url = videoItem?.videoURL {
                VideoPlayerView(videoURL: url).preferredColorScheme(.dark)
            }
        })
        .fullScreenCover(isPresented: $showingAudio, content: {
            if let video = videoItem {
                MediaPlayerView(videoItem: video, animation: Namespace().wrappedValue).preferredColorScheme(.dark)
            }
        })
    }
}

#Preview {
    VideoDetailsView()
}

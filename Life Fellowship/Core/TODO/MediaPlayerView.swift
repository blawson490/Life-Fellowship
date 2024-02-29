//
//  MediaPlayerView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/13/24.
//

import SwiftUI
import AVFoundation

struct MediaPlayerView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State var queue: [VideoItem] = []
    @State var videoItem: VideoItem?
    @State var index: Int = 0
    @State private var notes: String = "These are my notes."
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var sliderValue: Double = 0.0
    @State private var isSeeking: Bool = false
    
    @State private var isLoading: Bool = true
    var animation: Namespace.ID
    @State private var animationContent: Bool = false

    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            AsyncImage(url: videoItem?.thumbnailURL) { image in
                                image
                                    .resizable()
                                    .edgesIgnoringSafeArea(.all)
                                    .aspectRatio(contentMode: .fill)
                                    .blur(radius: 55)
                                    .opacity(0.75)
                                    .frame(height: size.height)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .matchedGeometryEffect(id: "BGVIEW", in: animation)
                    
                    if verticalSizeClass == .compact {
                        HStack (alignment: .center, spacing: 25) {
                            ThumbnailView(size)
                            
                            PlayerView(size)
                            
                            
                        }
                        .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                        .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                        .padding(.leading, safeArea.leading + (safeArea.trailing == 0 ? 10 : 0))
                        .padding(.trailing, safeArea.trailing == 0 ? 10 : safeArea.trailing)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .clipped()
                    } else {
                        VStack (spacing: 15) {
                            ThumbnailView(size)
                            
                            PlayerView(size)
                            
                            
                        }
                        .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                        .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                        .padding(.horizontal, 25)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .clipped()
                    }
                }
                .ignoresSafeArea(.container, edges: .all)
            }
            .onAppear {
                if videoItem == nil {
                    VideoFeedLoader().loadVideos { loadedVideos in
                        DispatchQueue.main.async {
                            if !loadedVideos.isEmpty {
                                self.queue = loadedVideos
                                self.videoItem = self.queue[index]
                                self.prepare()
                            }
                        }
                    }
                } else {
                    VideoFeedLoader().loadVideos { loadedVideos in
                        DispatchQueue.main.async {
                            if !loadedVideos.isEmpty {
                                self.queue = loadedVideos
                                // Find the index of the current videoItem in the new queue
                                if let currentIndex = self.queue.firstIndex(where: { $0.mediaID == self.videoItem?.mediaID }) {
                                    self.index = currentIndex
                                    self.videoItem = self.queue[currentIndex]
                                } else {
                                    self.videoItem = self.queue.first
                                }
                                self.prepare()
                                self.playAudio()
                            }
                        }
                    }
                }

            }
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                updateProgress()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showAlert = true
//                    } label: {
//                        Image(systemName: "bookmark")
//                    }
//                }
            }
            .navigationTitle("Listen")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("Coming Soon 🥳", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This feature is under development and will be available soon.")
        }
    }

    private func prepare() {
        isLoading = true
        guard let videoURL = videoItem?.videoURL else { return }

        // Attempt to safely downcast the current item's asset to AVURLAsset
        let currentURL = (player?.currentItem?.asset as? AVURLAsset)?.url

        if player == nil || currentURL != videoURL {
            self.configureAudioSession()
            self.player = AVPlayer(url: videoURL)
            let durationTime = player?.currentItem?.duration
            let durationSeconds = CMTimeGetSeconds(durationTime ?? CMTime())
            totalTime = durationSeconds.isNaN ? 0.0 : durationSeconds
            isLoading = false
        }
    }
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    private func updateProgress() {
        if isSeeking {
            currentTime = sliderValue
        } else {
            guard let player = player else {return}
            let currentTrackTime = player.currentItem?.currentTime()
            let currentTimeSeconds = CMTimeGetSeconds(currentTrackTime ?? CMTime())
            currentTime = currentTimeSeconds.isNaN ? 0.0 : currentTimeSeconds
            
            if !(currentTime > 1.0) {
                let durationTime = player.currentItem?.duration
                let durationSeconds = CMTimeGetSeconds(durationTime ?? CMTime())
                totalTime = durationSeconds.isNaN ? 0.0 : durationSeconds
            }
        }
    }
    private func seekAudio(to time: TimeInterval) {
        let cmTime = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        player?.seek(to: cmTime)
    }
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    @ViewBuilder
    func ThumbnailView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                AsyncImage(url: videoItem?.thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 40)
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                } placeholder: {
                    ProgressView()
                }
                
                AsyncImage(url: videoItem?.thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack (spacing: spacing) {
                VStack (spacing: spacing) {
                    HStack (alignment: .center, spacing: 15) {
                        VStack (alignment: .leading, spacing: 4) {
                            Text(videoItem?.title ?? "")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text(videoItem?.description ?? "")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color.white)
                                .padding(12)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                }
                        }
                    }
                    
                    Slider(value: $sliderValue, in: 0...totalTime, onEditingChanged: { isEditing in
                        self.isSeeking = isEditing
                        if isEditing {
                            currentTime = sliderValue
                        } else {
                            seekAudio(to: sliderValue)
                        }
                    })
                    .accentColor(.white)

                    
                    HStack {
                        Text(timeString(time: currentTime))
                        Spacer()
                        Text(timeString(time: totalTime))
                    }
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18) {
                    Button {
                        let existingIndex = index
                        // TODO: Add check for past 2-3 seconds
                        if existingIndex > 0 {
                            index = existingIndex - 1
                        } else {
                            seekAudio(to: 0)
                        }
                        if isPlaying {
                            stopAudio()
                            self.videoItem = queue[index]
                            prepare()
                            playAudio()
                        } else {
                            self.videoItem = queue[index]
                            prepare()
                        }
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    .foregroundStyle(isLoading ? Color.gray : Color.white)
                    .disabled(isLoading)
                    
                    
                    if isLoading {
                        ProgressView()
                    } else {
                        Button {
                            isPlaying ? stopAudio() : playAudio()
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(size.height < 300 ? .largeTitle : .system(size: 50))
                        }
                    }
                    
                    Button {
                        let existingIndex = index
                        index = existingIndex + 1
                        if isPlaying {
                            stopAudio()
                            self.videoItem = queue[index]
                            prepare()
                            playAudio()
                        } else {
                            self.videoItem = queue[index]
                            prepare()
                        }
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    .foregroundStyle(isLoading ? Color.gray : Color.white)
                    .disabled(isLoading)
                }
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: spacing) {
                    HStack(spacing: 15) {
                        Image(systemName: "speaker.fill")
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        
                        Image(systemName: "speaker.wave.3.fill")
                    }
                    
                    HStack(alignment: .top, spacing: size.width * 0.18) {
                        Button {
                            showAlert = true
                        } label: {
                            VStack(spacing: 6) {
                                Image(systemName: "play.circle")
                                    .font(.title2)
                                
                                Text("Watch")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: " ")
                                .font(.title2)
                        }
                        
                        Button {
                            showAlert = true
                        } label: {
                            VStack(spacing: 6) {
                                Image(systemName: "list.bullet")
                                    .font(.title2)
                                
                                Text("Queue")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .foregroundStyle(Color.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                }
                .frame(height: size.height / 2.5, alignment: .bottom)
            }
        }
    }

    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category. \(error)")
        }
    }

}

#Preview {
    MediaPlayerView(animation: Namespace().wrappedValue).preferredColorScheme(.dark)
}


extension View{
    var deviceCornerRadius: CGFloat {
        
        let key = "_deviceCornerRadius"
        
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0
    }
}

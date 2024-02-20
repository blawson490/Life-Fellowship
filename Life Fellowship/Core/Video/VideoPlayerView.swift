//
//  VideoPlayerView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dismiss) var dismiss
    var videoURL: URL
    @State private var notes: String = "These are my notes."
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            VStack {
                VideoPlayer(player: player)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .onAppear {
                        if !isPlaying {
                            self.player = AVPlayer(url: videoURL)
                            self.player?.play()
                            isPlaying = true
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "bookmark")
                    }
                }
            }
            .navigationTitle("Watch")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Coming Soon 🥳", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("This feature is under development and will be available soon.")
            }
        }
    }
}

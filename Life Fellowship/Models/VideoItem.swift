//
//  VideoItem.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import Foundation

struct VideoItem: Identifiable, Equatable {
    let mediaID: String
    var id: String {
        mediaID
    }
    let title: String
    let description: String
    let duration: String
    let pubDate: String
    let videoURL: URL
    let thumbnailURL: URL
}

//
//  Announcement.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import Foundation
import SwiftUI

struct DummyAnnouncement: Identifiable, Hashable, Encodable {
    var id: Int
    var title: String
    var description: String
    var shortDescription: String?
    var longDescription: String?
    var privacy: String?
    var createdTimestamp: Date?
    var updatedTimestamp: Date?
    var likes: Int?
    var saves: Int?
    var imageName : String
    var isFeatured: Bool
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_featured") : nil
    }
}

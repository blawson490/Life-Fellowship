//
//  Announcement.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import Foundation
import SwiftUI

struct Announcement {
    var id: Int
    var title: String
    var description: String
    var imageName : String
    var isFeatured: Bool
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_featured") : nil
    }
}

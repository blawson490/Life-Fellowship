//
//  Announcement.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/24/24.
//

import Foundation
import FirebaseFirestore

struct Announcement: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let title: String
    let image: URL? // must be optional to initialize ID
    let shortDescription: String
    let longDescription: String?
    let privacy: String
    let createdTimestamp: Date
    let updatedTimestamp: Date
    let createdBy: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case shortDescription
        case longDescription
        case privacy
        case createdTimestamp
        case updatedTimestamp
        case createdBy
    }
    
    // Firestore uses Timestamps, so we need to handle the conversion
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let imageUrlString = try container.decode(String.self, forKey: .image)
        image = URL(string: imageUrlString)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        longDescription = try container.decodeIfPresent(String.self, forKey: .longDescription)
        privacy = try container.decode(String.self, forKey: .privacy)
        createdBy = try container.decode(String.self, forKey: .createdBy)
        
        // Convert Timestamp to Date
        let createdTimestamp = try container.decode(Timestamp.self, forKey: .createdTimestamp)
        self.createdTimestamp = createdTimestamp.dateValue()
        
        let updatedTimestamp = try container.decode(Timestamp.self, forKey: .updatedTimestamp)
        self.updatedTimestamp = updatedTimestamp.dateValue()
    }
    
    // To Copy
    init(id: String, title: String, image: URL, shortDescription: String, longDescription: String?, privacy: String, createdTimestamp: Date, updatedTimestamp: Date, createdBy: String) {
        self.id = id
        self.title = title
        self.image = image
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.privacy = privacy
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
        self.createdBy = createdBy
    }
    
    // To Update
    init(id: String, title: String, image: URL, shortDescription: String, longDescription: String?, privacy: String, createdTimestamp: Date, createdBy: String) {
        self.id = id
        self.title = title
        self.image = image
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.privacy = privacy
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = Date.now
        self.createdBy = createdBy
    }
    
    // To Create
    init(title: String, shortDescription: String, longDescription: String?, privacy: String, createdBy: String) {
        self.title = title
        // No image when creating document.
        // Create document and update document from id to add image
        self.image = nil
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.privacy = privacy
        self.createdTimestamp = Date.now
        self.updatedTimestamp = Date.now
        self.createdBy = createdBy
    }
    
    // Encode from Date to Timestamp when saving to Firestore
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(shortDescription, forKey: .shortDescription)
        try container.encodeIfPresent(longDescription, forKey: .longDescription)
        try container.encode(privacy, forKey: .privacy)
        try container.encode(createdBy, forKey: .createdBy)
        
        // Convert Date to Timestamp
        try container.encode(Timestamp(date: createdTimestamp), forKey: .createdTimestamp)
        try container.encode(Timestamp(date: updatedTimestamp), forKey: .updatedTimestamp)
    }
}

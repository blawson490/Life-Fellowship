//
//  User.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    let id: String
    let type: String
    let fullname: String
    let email: String
    let profileImageUrl: String?
    let phone: String?
    let bio: String?
    let favoriteVerse: String?
    let verseIdentifier: String?
    let createdTimestamp: Date
    let updatedTimestamp: Date
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case fullname
        case email
        case profileImageUrl
        case phone
        case bio
        case favoriteVerse
        case verseIdentifier
        case createdTimestamp
        case updatedTimestamp
    }
    
    // Firestore uses Timestamps, so we need to handle the conversion
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        fullname = try container.decode(String.self, forKey: .fullname)
        email = try container.decode(String.self, forKey: .email)
        profileImageUrl = try container.decodeIfPresent(String.self, forKey: .profileImageUrl)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        favoriteVerse = try container.decodeIfPresent(String.self, forKey: .favoriteVerse)
        verseIdentifier = try container.decodeIfPresent(String.self, forKey: .verseIdentifier)
        
        // Convert Timestamp to Date
        let createdTimestamp = try container.decode(Timestamp.self, forKey: .createdTimestamp)
        self.createdTimestamp = createdTimestamp.dateValue()
        
        let updatedTimestamp = try container.decode(Timestamp.self, forKey: .updatedTimestamp)
        self.updatedTimestamp = updatedTimestamp.dateValue()
    }
    
    init(id: String, type: String, fullName: String, email: String, profileImageUrl: String?, phone: String?, bio: String?, favoriteVerse: String?, verseIdentifier: String?, createdTimestamp: Date, updatedTimestamp: Date) {
        self.id = id
        self.type = type
        self.fullname = fullName
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.phone = phone
        self.bio = bio
        self.favoriteVerse = favoriteVerse
        self.verseIdentifier = verseIdentifier
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
    }
    
    init(id: String, type: String, fullName: String, email: String, createdTimestamp: Date, updatedTimestamp: Date) {
        self.id = id
        self.type = type
        self.fullname = fullName
        self.email = email
        self.profileImageUrl = nil
        self.phone = nil
        self.bio = nil
        self.favoriteVerse = nil
        self.verseIdentifier = nil
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
    }
    
    init(id: String, type: String, fullName: String, email: String) {
        self.id = id
        self.type = type
        self.fullname = fullName
        self.email = email
        self.profileImageUrl = nil
        self.phone = nil
        self.bio = nil
        self.favoriteVerse = nil
        self.verseIdentifier = nil
        self.createdTimestamp = Date.now
        self.updatedTimestamp = Date.now
    }
    
    // Encode from Date to Timestamp when saving to Firestore
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(fullname, forKey: .fullname)
        try container.encode(email, forKey: .email)
        try container.encodeIfPresent(profileImageUrl, forKey: .profileImageUrl)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(favoriteVerse, forKey: .favoriteVerse)
        try container.encodeIfPresent(verseIdentifier, forKey: .verseIdentifier)
        
        // Convert Date to Timestamp
        try container.encode(Timestamp(date: createdTimestamp), forKey: .createdTimestamp)
        try container.encode(Timestamp(date: updatedTimestamp), forKey: .updatedTimestamp)
    }
}

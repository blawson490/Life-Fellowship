//
//  Devotional.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/5/24.
//

import Foundation

struct Devotional: Codable, Identifiable {
    var id: String
    var title: String
    var scripture: String
    var verse: String
    var insight: String
    var reflection: String
    var action: String
    var created: String
    var updated: String
    var forDate: String
    var collectionId: String
    var collectionName: String
    var hidden: Bool
}

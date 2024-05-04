//
//  Tab.swift
//  TabView Inception
//
//  Created by Blake Lawson on 5/3/24.
//

import Foundation

struct TabModel: Identifiable {
    private(set) var id: Tab
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case today = "Today"
        case community = "Community"
    }
}

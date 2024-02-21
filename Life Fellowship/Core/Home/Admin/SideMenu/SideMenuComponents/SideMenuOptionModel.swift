//
//  SideMenuOptionModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case home
    case search
    case requests
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .requests:
            return "Notifications"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .requests:
            return "bell"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int {
        return self.rawValue
    }
}

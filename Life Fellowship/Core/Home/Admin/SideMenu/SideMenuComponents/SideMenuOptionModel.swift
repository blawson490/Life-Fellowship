//
//  SideMenuOptionModel.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import Foundation
import SwiftUI

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
    
    var destination: any View {
        switch self {
        case .home:
            return ContentView()
        case .search:
            return SearchView()
        case .requests:
            return ProfileView()
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int {
        return self.rawValue
    }
}

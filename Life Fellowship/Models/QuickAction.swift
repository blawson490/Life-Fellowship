//
//  QuickAction.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import Foundation
import SwiftUI

struct QuickAction: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var color: Color
    var text: String
    var subText: String
}

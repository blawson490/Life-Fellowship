//
//  CloseKeyboard.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/24/24.
//

import SwiftUI

extension View {
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

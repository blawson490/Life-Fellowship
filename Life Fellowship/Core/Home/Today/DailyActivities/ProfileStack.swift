//
//  ProfileStack.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/5/24.
//

import SwiftUI

struct ProfileStack: View {
    var names: [String]
    var action: String

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            HStack(spacing: -6) {
                ForEach(displayedNames(), id: \.self) { name in
                    DefaultProfilePicture(name: name)
                }
            }
            
            Text(descriptionText())
                .foregroundStyle(.secondary)
                .font(.callout)
            
        }
        .onAppear()
    }
    
    private func displayedNames() -> [String] {
        var displayed = Array(names.shuffled().prefix(3))
        if names.count > 3 {
            displayed.append("+ \(names.count - 3)")
        }
        return displayed
    }
    
    private func descriptionText() -> String {
        if names.count > 3 {
            return "others are \(action)"
        } else {
            return "are \(action)"
        }
    }
}

#Preview {
    ProfileStack(names: ["Blake Lawson", "Trinity Lawson", "Luna Lawson", "Isaiah Martin", "Adilynn Lawson"], action: "praying")
}

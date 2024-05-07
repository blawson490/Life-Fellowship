//
//  DefaultProfilePicture.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/5/24.
//

import SwiftUI

struct DefaultProfilePicture: View {
    var name: String
    
    var body: some View {
        Text(initials(from: name))
            .foregroundColor(Color("CardBackground"))
            .font(.caption2)
            .fontWeight(.bold)
            .frame(width: 25, height: 25)
            .background(Circle().fill(randomPastelColor()).overlay(Circle().stroke(Color("CardBackground"), lineWidth: 2)))
    }
    
    private func initials(from name: String) -> String {
        let parts = name.split(separator: " ").map(String.init)
        switch parts.count {
        case 0:
            return ""
        case 1:
            return String(parts[0].prefix(2)).uppercased()
        case 2:
            return "\(parts[0].first!)\(parts[1].first!)".uppercased()
        default:
            return "\(parts.first!.first!)\(parts.last!.first!)".uppercased()
        }
    }
    
    private func randomPastelColor() -> Color {
        let hue = Double.random(in: 0...1)
        let saturation = Double.random(in: 0.4...0.7)
        let brightness = Double.random(in: 0.7...0.9)
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}

#Preview {
    DefaultProfilePicture(name: "William")
}

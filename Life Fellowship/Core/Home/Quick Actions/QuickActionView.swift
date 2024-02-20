//
//  QuickActionView.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct QuickActionView: View {
    var quickAction: QuickAction
    @State private var showAlert = false
    var body: some View {
        HStack (spacing: 16) {
            Image(systemName: quickAction.symbol)
                .foregroundColor(.white)
                .padding(8)
                .background(Circle().fill(quickAction.color))
            
            VStack (alignment: .leading) {
                Text(quickAction.text)
                    .font(.headline)
                Text(quickAction.subText)
                    .font(.caption)
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(radius: 2)
        )
        .onTapGesture {
            showAlert = true
        }
        .alert("Coming Soon 🥳", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This feature is under development and will be available soon.")
        }
    }
}

#Preview {
    QuickActionView(quickAction: QuickAction(symbol: "gift", color: Color.mint, text: "Give", subText: "Support your local church"))
}

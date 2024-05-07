//
//  Prayer.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/5/24.
//

import SwiftUI

struct PrayerQuote: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                Text("Breathe slowly and reflect.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .bold()
                
                Text("Let us come before Him with thanksgiving and extol him with music and song.")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .fontDesign(.monospaced)
                
                
                Text("Psalm 95:2")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .bold()
                
                Spacer()
            }
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(Color(uiColor: .label))
                                .padding(12)
                                .background(
                                    Circle()
                                        .fill(Color("AppBackground"))
                                )
                                .padding()
                        })
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color(uiColor: .label))
                                .padding()
                                .background(
                                    Circle()
                                        .fill(Color.accentColor)
                                )
                                .padding()
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    PrayerQuote()
}

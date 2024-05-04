//
//  DailyCardView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct DailyCardView: View {
    @Binding var isCompleted: Bool
    var isLast = false
    var systemImage = "heart"
    var title = "Practice Gratitude"
    var description = "What are you grateful for?"
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Circle()
                    .strokeBorder(isCompleted ? Color.clear : Color.blue, lineWidth: 3)
                    .background(isCompleted ? Circle().fill(Color.blue) : nil)
                    .frame(width: 20, height: 20)
                    .padding(.top, 30)
                    .padding(.trailing, 10)
                    
                VStack (spacing: 0) {
                    HStack {
                        Image(systemName: systemImage)
                            .padding(12)
                            .foregroundStyle(Color.gray)
                            .background {
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                            }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(Color.accentColor)
                    }
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text(title)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Text(description)
                            .font(.callout)
                            .bold()
                            .foregroundStyle(.primary)
                        HStack {
                            Spacer()
                        }
                    }
                    .padding()
                }
                .padding([.top, .horizontal])
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                }
            }
        }
        .background(alignment: .leading) {
            if !isLast {
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 1)
                    .offset(x: 10, y: 55)
                    .padding(.vertical, 8)
            }
        }
    }
}

#Preview {
    DailyCardView(isCompleted: .constant(false), isLast: false)
}

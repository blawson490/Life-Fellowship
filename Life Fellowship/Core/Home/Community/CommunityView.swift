//
//  CommunityView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Surround Yourself")
                .font(.title2.bold())
            Text("We all need friends - to encourage, inspire, challenge, and love us; and they need you too.")
            
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Add Friends")
                            .bold()
                            .foregroundStyle(Color.white)
                        
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(Color.accentColor))
                })
                Spacer()
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .tertiarySystemGroupedBackground))
        }
    }
}

#Preview {
    CommunityView()
}

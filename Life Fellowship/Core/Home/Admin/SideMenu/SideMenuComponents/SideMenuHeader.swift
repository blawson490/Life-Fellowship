//
//  SideMenuHeader.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import SwiftUI

struct SideMenuHeader: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Admin Menu")
                .font(.title2)
                .bold()
            HStack {
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Blake Lawson")
                        .font(.subheadline)
                    
                    Text("blawson490@gmail.com")
                        .font(.footnote)
                        .tint(.gray)
                }
            }
        }
    }
}

#Preview {
    SideMenuHeader()
}

//
//  CustomPageControl.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/23/24.
//

import SwiftUI

struct CustomPageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    var body: some View {
        HStack {
            ForEach (0 ..< numberOfPages) { page in
                    Rectangle()
                    .fill(page == currentPage ? Color.accentColor : Color(uiColor: .secondaryLabel))
                    .frame(maxWidth: 40, maxHeight: 4)
                
                .onTapGesture {
                    withAnimation {
                        if currentPage > page {
                            currentPage = (currentPage - 1) % numberOfPages
                        } else if currentPage < page {
                            currentPage = (currentPage + 1) % numberOfPages
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CustomPageControl(numberOfPages: 4, currentPage: .constant(2))
}

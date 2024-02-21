//
//  SideMenuView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @State private var selectedOption: SideMenuOptionModel = SideMenuOptionModel.home
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                            isShowing.toggle()
                    }
    
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        SideMenuHeader()
                        
                        VStack (alignment: .leading) {
                            ForEach(SideMenuOptionModel.allCases) { option in
                                Button {
                                    selectedOption = option
                                } label: {
                                    SideMenuItem(option: option, selectedOption: $selectedOption)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(Color(uiColor: .systemBackground))
                    
                    Spacer()
                }
                
                
            }
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    SideMenuView(isShowing: .constant(true))
}

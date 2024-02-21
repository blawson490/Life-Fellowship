//
//  SideMenuItem.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/20/24.
//

import SwiftUI

struct SideMenuItem: View {
    let option: SideMenuOptionModel
    @Binding var selectedOption: SideMenuOptionModel
    
    private var isSelected: Bool {
        return selectedOption == option
    }
    var body: some View {
        HStack {
            Image(systemName: option.systemImageName)
            Text(option.title)
        }
        .foregroundColor(isSelected ? .accentColor : .primary)
        .fontWeight(isSelected ? .medium : .regular)
        .padding()
        .frame(width: 216, height: 44, alignment: .leading)
        .background(isSelected ? .accent.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SideMenuItem(option: SideMenuOptionModel.home, selectedOption: .constant(SideMenuOptionModel.home))
}

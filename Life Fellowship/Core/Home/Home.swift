//
//  Home.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var tabs: [TabModel] = [
        .init(id: TabModel.Tab.today),
        .init(id: TabModel.Tab.community),
    ]
    @State private var selectedTab: TabModel.Tab = .today
    
    @State private var progress = CGFloat.zero
    
    @State private var mainViewScrollState: TabModel.Tab?
    @State private var tabBarScrollState: TabModel.Tab?
    @State private var showingStreak = false
    @State private var showingNotifications = false
    @State private var showingProfile = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack (spacing: 16){
                CustomTabBar()
                Spacer()
                if let currentUser = viewModel.currentUser {
                    Button(action: {
                        showingStreak = true
                    }, label: {
                        Image(systemName: "flame")
                    })
                    Button(action: {
                        showingNotifications = true
                    }, label: {
                        Image(systemName: "bell")
                    })
                    Button(action: {
                        showingProfile = true
                    }, label: {
                        Text("\(initials(from: currentUser.name))")
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(Color(uiColor: .systemGroupedBackground))
                            }
                    })
                } else {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Login")
                    })
                }
            }
            .foregroundStyle(.primary)
            .padding([.top, .horizontal], 15)
            .padding(.bottom, -8)
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        /// INDIVIDUAL TAB VIEWS
                        ForEach(tabs) { tab in
                            if tab.id.rawValue == "Today" {
                                TodayView()
                                    .frame(width: size.width, height: size.height)
                                    .contentShape(.rect)
                            } else if tab.id.rawValue == "Community" {
                                VStack {
                                    CommunityView()
                                    Spacer()
                                }
                                .padding([.top, .horizontal])
                                    .frame(width: size.width, height: size.height)
                                    .contentShape(.rect)
                            } else {
                                Text(tab.id.rawValue)
                                    .frame(width: size.width, height: size.height)
                                    .contentShape(.rect)
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .rect { rect in
                        progress = -rect.minX / size.width
                    }
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .onChange(of: mainViewScrollState) { oldValue, newValue in
                    if let newValue {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            tabBarScrollState = newValue
                            selectedTab = newValue
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingStreak, content: {
            Text("Streak")
        })
        .sheet(isPresented: $showingNotifications, content: {
            Text("Notifications")
        })
        .sheet(isPresented: $showingProfile, content: {
            VStack {
                Text("Profile")
                Button(role: .destructive, action: {
                    viewModel.logout()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Sign Out")
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.red))
                    .padding()
                })
            }
            .environmentObject(AuthViewModel())
        })
        .background(Color("AppBackground"))
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack (spacing: 20){
            ForEach($tabs) { $tab in
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedTab = tab.id
                        tabBarScrollState = tab.id
                        mainViewScrollState = tab.id
                    }
                }, label: {
                    Text(tab.id.rawValue)
                        .bold(selectedTab == tab.id)
                        .font(selectedTab == tab.id ? .title2 : .title3)
                        .foregroundStyle(selectedTab == tab.id ? .primary : Color.gray.opacity(0.75))
                })
                .buttonStyle(.plain)
                .rect { rect in
                    tab.size = rect.size
                    tab.minX = rect.minX
                }
            }
        }
        .padding(.vertical, 15)
        .overlay(alignment: .bottomLeading) {
            
            let inputRange = tabs.indices.compactMap { return CGFloat($0) }
            let ouputRange = tabs.compactMap { return $0.size.width }
            let outputPositionRange = tabs.compactMap { return $0.minX }
            let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: ouputRange)
            let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
            
            
            Rectangle()
                .fill(Color.accentColor)
                .frame(width: indicatorWidth, height: 4)
                .offset(x: indicatorPosition)
                .padding(.horizontal, -15)
        }
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
}

#Preview {
    Home()
        .environmentObject(AuthViewModel())
}


//
//  Home.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct Home: View {
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
    var body: some View {
        VStack {
            HStack (spacing: 16){
                CustomTabBar()
                Spacer()
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
                    Text("BL")
                        .padding(8)
                        .background {
                            Circle()
                                .fill(Color(uiColor: .systemGroupedBackground))
                        }
                })
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
            Text("Profile")
        })
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
}

#Preview {
    Home()
}


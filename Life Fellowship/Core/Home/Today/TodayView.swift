//
//  TodayView.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 5/4/24.
//

import SwiftUI

struct TodayView: View {
    @State private var completedActivities: Set<ActivityState> = []
    
    let activities: [ActivityState: DailyActivity] = [
        .grateful: DailyActivity(name: "grateful", image: "heart.text.square", title: "Practice Gratitude", description: "What are you grateful for?"),
        .prayer: DailyActivity(name: "prayer", image: "hands.sparkles", title: "Pray for Others", description: "Pray with your community."),
        .kindness: DailyActivity(name: "kindness", image: "hand.raised.fill", title: "Acts of Kindness", description: "Make a positive impact today.")
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                headerView
                
                ForEach(ActivityState.allCases, id: \.self) { state in
                    activityCard(for: state)
                }
            }
            .padding([.top, .horizontal])
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .refreshable {
            completedActivities.removeAll()
        }
    }
    
    var headerView: some View {
        Text("Today")
            .font(.headline)
            .foregroundStyle(.secondary)
            .padding(.top)
    }
    
    @ViewBuilder
    func activityCard(for state: ActivityState) -> some View {
        if let activity = activities[state] {
            DailyCardView(isCompleted: bindingForActivity(state),
                          isLast: state == .kindness,
                          systemImage: activity.image,
                          title: activity.title,
                          description: activity.description)
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                    _ = completedActivities.insert(state)
                }
            }
        }
    }
    
    func bindingForActivity(_ activity: ActivityState) -> Binding<Bool> {
            Binding<Bool>(
                get: { completedActivities.contains(activity) },
                set: { isCompleted in
                    if isCompleted {
                        completedActivities.insert(activity)
                    } else {
                        completedActivities.remove(activity)
                    }
                }
            )
        }
}

enum ActivityState: CaseIterable {
    case grateful, prayer, kindness
}

#Preview {
    TodayView()
}

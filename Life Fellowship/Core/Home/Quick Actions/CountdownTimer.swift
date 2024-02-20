//
//  CountdownTimer.swift
//  Life Fellowship Guest Demo App
//
//  Created by Blake Lawson on 2/8/24.
//

import SwiftUI

struct CountdownTimer: View {
    @State private var countdownText = " "
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack (alignment: .leading) {
            Text("Next Service")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            HStack {
                Spacer()
                if countdownText == " " {
                    HStack {
                        Text(countdownText)
                        ProgressView()
                    }.onReceive(timer) { _ in
                        countdownText = getNextServiceCountdown()
                    }
                } else {
                    Text(countdownText)
                        .font(.title2)
                        .onReceive(timer) { _ in
                            countdownText = getNextServiceCountdown()
                        }
                        .padding()
                }
                Spacer()
            }
            .frame(minHeight: 60)
            .background(Color(UIColor.systemBackground).cornerRadius(8))
            .padding(.horizontal)
        }
    }
    
    func getNextServiceCountdown() -> String {
            let now = Date()
            let calendar = Calendar.current
            var nextServiceDate: Date?

            let serviceTimes = [(weekday: 4, hour: 18, minute: 0), // Wednesday at 6pm
                                (weekday: 1, hour: 10, minute: 0)] // Sunday at 10am

            // Next service date
            for serviceTime in serviceTimes {
                var components = calendar.dateComponents([.year, .month, .weekday, .hour, .minute], from: now)
                components.weekday = serviceTime.weekday
                components.hour = serviceTime.hour
                components.minute = serviceTime.minute

                if let serviceDate = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTime) {
                    if nextServiceDate == nil || serviceDate < nextServiceDate! {
                        nextServiceDate = serviceDate
                    }
                }
            }

            guard let nextServiceDate = nextServiceDate else {
                return "Date calculation error"
            }

            // Calculate the difference
            let components = calendar.dateComponents([.day, .hour, .minute], from: now, to: nextServiceDate)
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0

            var countdownString = ""
            if days > 0 {
                countdownString += "\(days) days "
            }
            countdownString += "\(hours) hours \(minutes) minutes"

            return countdownString
        }
}

#Preview {
    CountdownTimer()
}

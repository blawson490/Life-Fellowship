//
//  LoadingViews.swift
//  Life Fellowship
//
//  Created by Blake Lawson on 2/19/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                GradientCircleView()
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                Spacer()
            }
            Spacer()
        }
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct GradientCircleView: View {
    // Animation state
    @State private var isAnimating = false
    
    var body: some View {
        // The circle with a gradient stroke
        Circle()
            .strokeBorder(
                AngularGradient(gradient: Gradient(colors: [.purple, .blue, .teal, .mint, .teal, .blue, .purple]), center: .center),
                lineWidth: 10
            )
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear() {
                // Start the animation
                self.isAnimating = true
            }
    }
}

#Preview {
    LoadingView()
}

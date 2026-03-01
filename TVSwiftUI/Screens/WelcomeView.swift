//
//  WelcomeView.swift
//  TVSwiftUI
//
//  Created by Lokesh Kumawat on 06/02/26.
//

import SwiftUI

struct WelcomeView: View {
    @State private var animateGradient = false
    @State private var revealedText: String = ""
    private let fullText: String = "Welcome to Enjoying Netflix on TV App"
    @StateObject private var router = Router<NetflixDestination>()

    var body: some View {
        NavigationStack(path: $router.path) {
            FullScreenBackground() {
                VStack {
                    Text(revealedText)
                        .font(.largeTitle).bold()
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    .red, .orange, .yellow, .green, .blue, .indigo, .purple
                                ],
                                startPoint: animateGradient ? .topLeading : .bottomTrailing,
                                endPoint: animateGradient ? .bottomTrailing : .topLeading
                            )
                        )
                        .onAppear {
                            // Start gradient animation
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                                animateGradient = true
                            }
                            // Typewriter effect
                            revealedText = ""
                            let characters = Array(fullText)
                            var index = 0
                            Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
                                if index < characters.count {
                                    revealedText.append(characters[index])
                                    index += 1
                                } else {
                                    timer.invalidate()
                                }
                            }
                        }
                }
                .padding()
            }
            .navigationDestination(for: NetflixDestination.self) { route in
                route.view()
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.router.push(.netflixDashboard)
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    WelcomeView()
}

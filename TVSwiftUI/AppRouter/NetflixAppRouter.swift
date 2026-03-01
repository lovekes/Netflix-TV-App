//
//  NetflixAppRouter.swift
//  TVSwiftUI
//
//  Created by Lokesh Kumawat on 01/03/26.
//

import SwiftUI
import Combine

final class Router<Route: NetflixAppRouter>: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) { path.append(route) }
    func pop() { path.removeLast() }
    func popToRoot() { path = NavigationPath() }
}

protocol NetflixAppRouter: Hashable {
    associatedtype V: View
    @ViewBuilder func view() -> V
}


enum NetflixDestination: NetflixAppRouter {
    case netflixDashboard
    case netflixMoviePlayer(Poster)
    // Manual Equatable implementation
    static func == (lhs: NetflixDestination, rhs: NetflixDestination) -> Bool {
        switch (lhs, rhs) {
        case (.netflixMoviePlayer(let a), .netflixMoviePlayer(let b)):
            return true
        case (.netflixDashboard, _):
            return true
        case (_, .netflixDashboard):
            return true
        }
    }

    // Manual Hashable implementation
    func hash(into hasher: inout Hasher) {
        switch self {
        case .netflixDashboard:
            hasher.combine(1)
        case .netflixMoviePlayer(let poster):
            hasher.combine(2)
            hasher.combine(poster)
        }
    }

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .netflixDashboard:
            NetflixDashboardView()
        case .netflixMoviePlayer(let poster):
            NetflixMoviePlayerView(poster: poster)
        }
    }
}



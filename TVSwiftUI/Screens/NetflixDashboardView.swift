//
//  NetflixDashboardView.swift
//  TVSwiftUI
//
//  Created by Lokesh Kumawat on 01/03/26.
//

import SwiftUI

struct NetflixDashboardView: View {
    @EnvironmentObject var router: Router<NetflixDestination>
    
    var body: some View {
        FullScreenBackground(color: .black) {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    HeroHeader()
                    
                    CarouselSection(title: "Trending Now", posters: Poster.sampleTrending) { selectedItem in
                        print("Selected Trending:", selectedItem)
                        router.push(.netflixMoviePlayer(selectedItem))
                    }
                    
                    CarouselSection(title: "Popular on Netflix", posters: Poster.samplePopular) { selectedItem in
                        print("Selected Popular:", selectedItem)
                        router.push(.netflixMoviePlayer(selectedItem))
                    }
                    CarouselSection(title: "Top Picks for You", posters: Poster.sampleTopPicks) { selectedItem in
                        print("Selected Top Picks:", selectedItem)
                        router.push(.netflixMoviePlayer(selectedItem))
                    }
                    
                    InfoTilesSection()
                }
                .padding(.vertical, 60)
                .padding(.leading, 10)
            }
        }
    }
}
// MARK: - Model
struct Poster: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String // use asset names or system placeholders
    static let sampleTrending: [Poster] = [
        .init(title: "Show 1", imageName: "show_1"),
        .init(title: "Show 2", imageName: "show_2"),
        .init(title: "Show 3", imageName: "show_3"),
        .init(title: "Show 4", imageName: "show_4"),
        .init(title: "Show 5", imageName: "show_5"),
        .init(title: "Show 6", imageName: "show_6"),
        .init(title: "Show 7", imageName: "show_7"),
        .init(title: "Show 8", imageName: "show_8"),
        .init(title: "Show 9", imageName: "show_9"),
        .init(title: "Show 10", imageName: "show_10")
    ]
    static let samplePopular: [Poster] = [
        .init(title: "Popular 1", imageName: "popular_1"),
        .init(title: "Popular 2", imageName: "popular_2"),
        .init(title: "Popular 3", imageName: "popular_3"),
        .init(title: "Popular 4", imageName: "popular_4"),
        .init(title: "Popular 5", imageName: "popular_5"),
        .init(title: "Popular 6", imageName: "popular_6"),
        .init(title: "Popular 7", imageName: "popular_7"),
        .init(title: "Popular 8", imageName: "popular_8"),
        .init(title: "Popular 9", imageName: "popular_9"),
        .init(title: "Popular 10", imageName: "popular_10")
    ]
    static let sampleTopPicks: [Poster] = [
        .init(title: "Pick 1", imageName: "pick_1"),
        .init(title: "Pick 2", imageName: "pick_2"),
        .init(title: "Pick 3", imageName: "pick_3"),
        .init(title: "Pick 4", imageName: "pick_4"),
        .init(title: "Pick 5", imageName: "pick_5"),
        .init(title: "Pick 6", imageName: "pick_6"),
        .init(title: "Pick 7", imageName: "pick_7"),
        .init(title: "Pick 8", imageName: "pick_8"),
        .init(title: "Pick 9", imageName: "pick_9"),
        .init(title: "Pick 10", imageName: "pick_10")
    ]
}

// MARK: - Hero Header
private struct HeroHeader: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.red.opacity(0.9), .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 320)
                .overlay(
                    Image(systemName: "play.rectangle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.white.opacity(0.15))
                        .padding(40)
                )
            VStack(alignment: .leading, spacing: 12) {
                Text("Netflix TV App")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Label("Play", systemImage: "play.fill")
                            .font(.title3.weight(.semibold))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 18)
                            .background(Color.white)
                            .foregroundStyle(.black)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .focusable(true)
                    
                    Button(action: {}) {
                        Label("My List", systemImage: "plus")
                            .font(.title3.weight(.semibold))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 18)
                            .background(Color.white.opacity(0.12))
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(Color.white.opacity(0.25), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                    .focusable(true)
                }
            }
            .padding(24)
        }
    }
}

// MARK: - Carousel Section
private struct CarouselSection: View {
    let title: String
    let posters: [Poster]
    @FocusState private var focusedID: UUID?
    var action: (Poster) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title2.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(posters) { poster in
                        PosterCard(poster: poster, isFocused: focusedID == poster.id) { selectedPoster in
                            action(selectedPoster)
                        }
                        .focused($focusedID, equals: poster.id)
                        .padding()
                    }
                }
                .padding(.horizontal, 6)
            }
        }
    }
}

// MARK: - Poster Card
private struct PosterCard: View {
    let poster: Poster
    let isFocused: Bool
    var action: (Poster) -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .frame(width: 260, height: 380)
                .overlay(
                    Image(poster.imageName)
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.85))
                )
            //                Text(poster.title)
            //                    .font(.headline)
            //                    .foregroundStyle(.white)
            //                    .padding(12)
            //                    .background(
            //                        RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.5))
            //                    )
            //                    .padding(10)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(isFocused ? 0.6 : 0.18), lineWidth: isFocused ? 2 : 1)
        )
        .shadow(color: Color.black.opacity(isFocused ? 0.5 : 0.25), radius: isFocused ? 24 : 12, x: 0, y: isFocused ? 18 : 8)
        .scaleEffect(isFocused ? 1.06 : 1.0)
        .animation(.easeInOut(duration: 0.18), value: isFocused)
        .focusable(true)
        .onTapGesture {
            action(poster)
        }
    }
}

// MARK: - Info Tiles Section
private struct InfoTilesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("More reasons to join")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
            
            HStack(spacing: 20) {
                InfoTile(title: "Enjoy on your TV", subtitle: "Watch on smart TVs, consoles, Apple TV, and more.", systemImage: "tv.fill")
                InfoTile(title: "Download shows", subtitle: "Save your favorites to watch offline.", systemImage: "arrow.down.circle.fill")
                InfoTile(title: "Watch everywhere", subtitle: "Stream unlimited movies and shows.", systemImage: "sparkles.tv.fill")
                InfoTile(title: "Create profiles", subtitle: "For kids or anyone in the family.", systemImage: "person.2.fill")
            }
        }
    }
}

private struct InfoTile: View {
    let title: String
    let subtitle: String
    let systemImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(.white)
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(20)
        .frame(width: 360, height: 160, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
    }
}


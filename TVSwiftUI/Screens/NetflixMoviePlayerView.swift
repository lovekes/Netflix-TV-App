//
//  NetflixMoviePlayerView.swift
//  TVSwiftUI
//
//  Created by Lokesh Kumawat on 01/03/26.
//

import SwiftUI

public struct NetflixMoviePlayerView: View {
    var poster: Poster
    
    public var body: some View {
        FullScreenBackground(color: .black) {
            ZStack(alignment: .top) {
                VideoPlayerView(
                    url: URL(string: "https://www.pexels.com/download/video/6580589/")!
                )
                
                HStack {
                    Image(poster.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(8)
                    Text(poster.title)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(12)
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.5))
                )
            }
        }
    }
}

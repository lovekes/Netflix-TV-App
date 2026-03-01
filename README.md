# Netflix TV App (SwiftUI)

An attractive, high‑performance Netflix‑style TV app built with SwiftUI for tvOS. It features a cinematic UI, smooth focus interactions on Apple TV, and seamless streaming video playback.


https://github.com/user-attachments/assets/c05abe1d-df64-4429-a301-b0ed0b01a4dc


## ✨ Features
- Beautiful, Netflix‑inspired UI with hero artwork and poster rows
- Smooth focus navigation for tvOS and adaptive layouts for iPhone/iPad
- Full‑screen streaming video playback with overlay metadata
- Modular SwiftUI components for easy customization
- Ready for real data sources (swap in your API or local JSON)

## 🎥 Streaming Video Playback

The app includes a reusable `VideoPlayerView` that streams remote content. The player is used by `NetflixMoviePlayerView`, which displays the current title and artwork in a sleek overlay.

```swift
let poster = Poster(imageName: "samplePoster", title: "Sample Title")
NetflixMoviePlayerView(poster: poster)


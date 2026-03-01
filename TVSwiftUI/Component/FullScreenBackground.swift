//
//  FullScreenBackground.swift
//  TVSwiftUI
//
//  Created by Lokesh Kumawat on 06/02/26.
//

import SwiftUI

// Generic container that renders a full-screen background color behind its content.
public struct FullScreenBackground<Content: View>: View {
    private let backgroundColor: Color
    private let content: Content

    public init(color: Color = .black, @ViewBuilder content: () -> Content) {
        self.backgroundColor = color
        self.content = content()
    }

    public var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            content
        }
    }
}

// ViewModifier for applying a full-screen background color to any view.
public struct FullScreenBackgroundModifier: ViewModifier {
    let color: Color

    public init(color: Color = .black) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        ZStack {
            color
                .ignoresSafeArea()
            content
        }
    }
}

public extension View {
    // Convenience API: apply a full-screen background color.
    func fullScreenBackground(_ color: Color = .black) -> some View {
        modifier(FullScreenBackgroundModifier(color: color))
    }
}

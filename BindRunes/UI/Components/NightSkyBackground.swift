//
//  NightSkyBackground.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct NightSkyBackground: View {
    var body: some View {
        ZStack {
            // 1) Fond bleu nuit
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.07, blue: 0.18),
                    Color(red: 0.02, green: 0.04, blue: 0.12)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // 2) Brume galactique
            GalaxyMist()
                .blendMode(.screen)

            // 3) Étoiles
            StarsField(starCount: 220)
        }
        .ignoresSafeArea()
    }
}

private struct GalaxyMist: View {
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color.blue.opacity(0.20),
                    Color.clear
                ],
                center: .center,
                startRadius: 60,
                endRadius: 420
            )
            .blur(radius: 90)

            RadialGradient(
                colors: [
                    Color.white.opacity(0.12),
                    Color.clear
                ],
                center: .topTrailing,
                startRadius: 40,
                endRadius: 300
            )
            .blur(radius: 100)
        }
    }
}

private struct StarsField: View {
    let starCount: Int

    var body: some View {
        GeometryReader { _ in
            Canvas { context, size in
                for _ in 0..<starCount {
                    let x = CGFloat.random(in: 0...size.width)
                    let y = CGFloat.random(in: 0...size.height)

                    let r = CGFloat.random(in: 0.4...1.4)
                    let a = Double.random(in: 0.3...0.9)

                    let rect = CGRect(x: x, y: y, width: r, height: r)
                    context.fill(Path(ellipseIn: rect),
                                 with: .color(.white.opacity(a)))
                }
            }
        }
    }
}

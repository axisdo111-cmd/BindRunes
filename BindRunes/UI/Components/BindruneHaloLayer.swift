//
//  BindruneHaloLayer.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct BindruneHaloLayer: View {
    let size: CGFloat
    let active: Bool

    @State private var phase = false

    var body: some View {
        Group {
            if active {
                Circle()
                    .stroke(Color.blue.opacity(0.30), lineWidth: 2)
                    .frame(width: size, height: size)
                    .blur(radius: phase ? 24 : 18)
                    .opacity(phase ? 0.35 : 0.25)
                    .allowsHitTesting(false)
                    .compositingGroup()
                    .drawingGroup()
            }
        }
        .onAppear {
            start()
        }
    }

    private func start() {
        guard active else { return }
        phase = false
        withAnimation(
            .easeInOut(duration: 6)
                .repeatForever(autoreverses: true)
        ) {
            phase = true
        }
    }
}

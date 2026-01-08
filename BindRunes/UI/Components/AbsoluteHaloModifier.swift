//
//  AbsoluteHaloModifier.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

/// Halo stable, non intrusif, sans impact layout
struct AbsoluteHaloModifier: ViewModifier {
    let color: Color
    let active: Bool

    @State private var phase = false

    func body(content: Content) -> some View {
        content
            .overlay {
                if active {
                    Circle()
                        .stroke(color.opacity(0.30), lineWidth: 2)
                        .frame(width: 260, height: 260)   // 🔒 TAILLE FIXE (clé)
                        .blur(radius: phase ? 24 : 18)
                        .opacity(phase ? 0.35 : 0.25)
                        .allowsHitTesting(false)
                        .compositingGroup()
                        .drawingGroup()
                }
            }
            // ⛔️ aucune animation implicite
            .animation(nil, value: phase)
            .onAppear {
                start()
            }
            // ✅ iOS 17+ : closure à 2 paramètres (old/new)
            .onChange(of: active) { _, _ in
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

extension View {
    func absoluteHalo(color: Color, active: Bool) -> some View {
        modifier(AbsoluteHaloModifier(color: color, active: active))
    }
}

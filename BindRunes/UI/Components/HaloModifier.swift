//
//  HaloModifier.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct PulsingHalo: ViewModifier {
    let color: Color
    let active: Bool
    
    @State private var pulse = false
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if active {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.8), lineWidth: 2)
                        .blur(radius: pulse ? 18 : 8)
                        .scaleEffect(pulse ? 1.12 : 0.98)
                        .opacity(pulse ? 0.8 : 0.5)
                        .allowsHitTesting(false)
                }
            }
            .compositingGroup() // ⭐ CRUCIAL
            .onAppear {
                if active {
                    withAnimation(
                        .easeInOut(duration: 1.6)
                        .repeatForever(autoreverses: true)
                    ) {
                        pulse = true
                    }
                }
            }
            .onChange(of: active) {
                if active {
                    pulse = false
                    withAnimation(
                        .easeInOut(duration: 1.6)
                            .repeatForever(autoreverses: true)
                    ) {
                        pulse = true
                    }
                }
            }
    }
}

extension View {
    func pulsingHalo(color: Color, active: Bool) -> some View {
        modifier(PulsingHalo(color: color, active: active))
    }
}

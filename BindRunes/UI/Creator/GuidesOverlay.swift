//
//  GuidesOverlay.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct GuidesOverlay: View {
    let guides: [GuideLine]

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let cx = w / 2
            let cy = h / 2

            Canvas { ctx, _ in
                for g in guides {
                    var p = Path()
                    switch g {
                    case .centerVertical:
                        p.move(to: CGPoint(x: cx, y: 0))
                        p.addLine(to: CGPoint(x: cx, y: h))

                    case .centerHorizontal:
                        p.move(to: CGPoint(x: 0, y: cy))
                        p.addLine(to: CGPoint(x: w, y: cy))
                    }
                    ctx.stroke(p,
                               with: .color(.cyan.opacity(0.35)),
                               lineWidth: 2)
                }
            }
        }
        .allowsHitTesting(false)
    }
}

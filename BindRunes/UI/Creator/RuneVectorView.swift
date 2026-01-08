//
//  RuneVectorView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct RuneVectorView: View {
    let layer: BindruneLayer
    var lineWidth: CGFloat = 10

    var body: some View {
        GeometryReader { geo in
            let rect = geo.frame(in: .local)
            if let path = RunePathFactory.path(for: layer.runeKey, in: rect.insetBy(dx: 18, dy: 18)) {
                path
                    .stroke(.cyan, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .shadow(color: .cyan.opacity(0.7), radius: 18)
                    .shadow(color: .cyan.opacity(0.35), radius: 36)
                    .opacity(layer.opacity)
            } else {
                // fallback Unicode
                Text(layer.glyph).font(.system(size: geo.size.width * 0.55))
                    .foregroundStyle(.cyan)
                    .shadow(color: .cyan.opacity(0.6), radius: 18)
                    .opacity(layer.opacity)
            }
        }
    }
}

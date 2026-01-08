//
//  BindruneCanvasView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct BindruneCanvasView: View {
    @Binding var layers: [BindruneLayer]
    @Binding var selectedLayerID: UUID?

    // Snap & guides
    @State private var activeGuides: [GuideLine] = []
    private let snapCfg = SnapConfig()

    // 🔒 CONSTANTES FIXES (clé anti-yoyo)
    private let canvasSize: CGFloat = 300
    private let baseFontSize: CGFloat = 110

    var body: some View {
        ZStack {
            // Fond du disque (fixe)
            Circle()
                .fill(Color.black.opacity(0.12))
                .frame(width: canvasSize, height: canvasSize)

            ForEach(layers) { layer in
                runeLayer(layer)
            }
        }
        .frame(width: canvasSize, height: canvasSize)
        .contentShape(Rectangle())
        .clipped() // 🔒 interdit tout recentrage dynamique
    }

    // MARK: - Rune Layer

    @ViewBuilder
    private func runeLayer(_ layer: BindruneLayer) -> some View {
        let isSelected = (layer.id == selectedLayerID)

        Text(layer.glyph)
            .font(.system(size: baseFontSize, weight: .regular))
            .opacity(layer.opacity)
            .scaleEffect(
                x: layer.isMirrored ? -layer.scale : layer.scale,
                y: layer.scale
            )
            .rotationEffect(.degrees(layer.rotation))
            .offset(x: layer.x, y: layer.y)
            .shadow(radius: 14)
            .overlay {
                if isSelected {
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .frame(width: canvasSize * 0.72)
                        .opacity(0.35)
                }
            }
            .gesture(dragGesture(for: layer))
            .onTapGesture {
                selectedLayerID = layer.id
            }
    }

    // MARK: - Drag Gesture

    private func dragGesture(for layer: BindruneLayer) -> some Gesture {
        DragGesture()
            .onChanged { value in
                guard let idx = layers.firstIndex(where: { $0.id == layer.id }) else { return }
                selectedLayerID = layer.id

                let newX = layers[idx].x + value.translation.width * 0.02
                let newY = layers[idx].y + value.translation.height * 0.02

                let snapped = SnapEngine.snapOffset(
                    x: newX,
                    y: newY,
                    in: CGSize(width: canvasSize, height: canvasSize),
                    cfg: snapCfg
                )

                layers[idx].x = snapped.0
                layers[idx].y = snapped.1
                activeGuides = snapped.2
            }
            .onEnded { _ in
                activeGuides = []
            }
    }
}


private extension BindruneCanvasView {

    func runeView(
        for layer: BindruneLayer,
        in geo: GeometryProxy
    ) -> some View {

        let isSelected = (layer.id == selectedLayerID)

        return RuneVectorView(layer: layer)
            .frame(
                width: geo.size.width * 0.7,
                height: geo.size.height * 0.7
            )
            .scaleEffect(
                x: layer.isMirrored ? -layer.scale : layer.scale,
                y: layer.scale
            )
            .rotationEffect(Angle.degrees(layer.rotation)) // ⬅️ important
            .offset(x: layer.x, y: layer.y)
            .overlay {
                if isSelected {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .foregroundStyle(.cyan.opacity(0.4))
                        .frame(width: geo.size.width * 0.75)
                }
            }
            .gesture(dragGesture(for: layer))
            .onTapGesture {
                selectedLayerID = layer.id
            }
    }
}

//
//  LayerEditorView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct LayerEditorView: View {
    @Binding var layers: [BindruneLayer]
    @Binding var selectedLayerID: UUID?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Couches").font(.headline)

            // Réordonner = swap/drag
            List {
                ForEach(layers) { layer in
                    HStack {
                        Text(layer.glyph).font(.title2)
                        Text(layer.runeKey).foregroundStyle(.secondary)
                        Spacer()
                        if layer.id == selectedLayerID { Image(systemName: "checkmark.circle.fill") }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { selectedLayerID = layer.id }
                }
                .onMove { from, to in
                    layers.move(fromOffsets: from, toOffset: to)
                }
                .onDelete { idx in
                    layers.remove(atOffsets: idx)
                    if !layers.contains(where: { $0.id == selectedLayerID }) {
                        selectedLayerID = layers.first?.id
                    }
                }
            }
            .frame(height: 220)

            if let id = selectedLayerID,
               let idx = layers.firstIndex(where: { $0.id == id }) {
                LayerControls(layer: $layers[idx])
            } else {
                Text("Sélectionne une couche pour l’éditer.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct LayerControls: View {
    @Binding var layer: BindruneLayer

    var body: some View {
        GroupBox("Réglages couche") {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Toggle("Miroir", isOn: $layer.isMirrored)
                    Spacer()
                    Button("Reset") {
                        layer.x = 0; layer.y = 0
                        layer.rotation = 0; layer.scale = 1
                        layer.opacity = 1; layer.isMirrored = false
                    }
                }

                HStack { Text("Scale"); Slider(value: $layer.scale, in: 0.4...2.0) }
                HStack { Text("Rotation"); Slider(value: $layer.rotation, in: -180...180) }
                HStack { Text("Opacité"); Slider(value: $layer.opacity, in: 0.15...1.0) }
            }
        }
    }
}

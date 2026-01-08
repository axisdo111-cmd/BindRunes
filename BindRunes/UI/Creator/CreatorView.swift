//
//  CreatorView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//
import SwiftUI

struct CreatorView: View {
    @StateObject private var store = RuneLibraryStore()

    @State private var layers: [BindruneLayer] = []
    @State private var selectedLayerID: UUID? = nil

    @State private var intentText: String = "Réussite financière"
    @State private var selectedTags: Set<IntentTag> = [.finance, .success]

    // Tuning UI
    private let canvasHeight: CGFloat = 320
    private let haloSize: CGFloat = 260

    var body: some View {
        NavigationStack {
            ZStack {
                NightSkyBackground()

                // 🔮 HALO ABSOLU : hors ScrollView => zéro rebond
                BindruneHaloLayer(size: haloSize, active: true)
                    .offset(y: haloOffsetY)
                    .accessibilityHidden(true)

                // UI principale
                VStack(spacing: 0) {
                    titleHeader
                        .zIndex(10)

                    ScrollView {
                        VStack(spacing: 16) {

                            // Canvas (sans animation attachée)
                            BindruneCanvasView(
                                layers: $layers,
                                selectedLayerID: $selectedLayerID
                            )
                            .frame(height: canvasHeight)
                            .padding(.horizontal)
                            .padding(.top, 12)

                            // Intent
                            GroupBox("Intention") {
                                VStack(alignment: .leading, spacing: 10) {
                                    TextField("Intention", text: $intentText)
                                        .textFieldStyle(.roundedBorder)

                                    FlowIntentTags(selected: $selectedTags)

                                    Button("Générer depuis intention") {
                                        generateFromIntent()
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                            .padding(.horizontal)

                            // Layers list/editor
                            LayerEditorView(layers: $layers, selectedLayerID: $selectedLayerID)
                                .padding(.horizontal)

                            // Export
                            GroupBox("Export") {
                                HStack {
                                    Button("Exporter PNG (1024)") {
                                        exportPNG()
                                    }
                                    .buttonStyle(.borderedProminent)

                                    Button("Ajouter une rune") {
                                        addRuneQuickPick()
                                    }
                                    .buttonStyle(.bordered)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 24)
                    }
                }
            }
        }
        .onAppear(perform: bootstrapIfNeeded)
    }

    /// Position verticale du halo : alignée visuellement avec le centre du canvas.
    /// On met une valeur stable (pas dépendante de ScrollView).
    private var haloOffsetY: CGFloat {
        // Header ~ (10 + 34 + 6 + 16 + 12) + marges => environ 90-100
        // Canvas commence après top padding(12). On vise le centre du canvas.
        let headerApprox: CGFloat = 96
        let canvasTopPadding: CGFloat = 12
        let centerInCanvas: CGFloat = canvasHeight / 2
        return headerApprox + canvasTopPadding + centerInCanvas - (haloSize / 2)
    }

    // MARK: - Header (fixe, sous Dynamic Island)

    private var titleHeader: some View {
        VStack(spacing: 6) {
            Text("BindRunes")
                .font(.system(size: 34, weight: .semibold, design: .serif))
                .tracking(4)

            Text("Crafter")
                .font(.system(size: 16, weight: .medium, design: .serif))
                .opacity(0.78)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(
            LinearGradient(
                colors: [
                    Color.black.opacity(0.55),
                    Color.black.opacity(0.20)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay(
            Rectangle()
                .fill(Color.white.opacity(0.10))
                .frame(height: 1),
            alignment: .bottom
        )
        .accessibilityElement(children: .combine)
    }

    // MARK: - Lifecycle

    private func bootstrapIfNeeded() {
        store.load()
        guard layers.isEmpty else { return }

        // preset démarrage
        layers = [
            .init(runeKey: "fehu", glyph: "ᚠ"),
            .init(runeKey: "jera", glyph: "ᛃ", rotation: 90),
            .init(runeKey: "othala", glyph: "ᛟ", scale: 0.9)
        ]
        selectedLayerID = layers.first?.id
    }

    // MARK: - Actions

    private func generateFromIntent() {
        guard let lib = store.library else { return }

        let req = IntentRequest(tags: Array(selectedTags), intensity: 0.6, maxRunes: 4)
        let keys = IntentGenerator.suggestRuneKeys(for: req)

        let all = lib.aetts.flatMap { $0.runes }
        let picked = keys.compactMap { k in all.first(where: { $0.key == k }) }

        layers = picked.enumerated().map { i, r in
            var layer = BindruneLayer(runeKey: r.key, glyph: r.glyph)
            layer.rotation = Double(i) * 45
            layer.scale = (i == 0) ? 1.0 : 0.92
            return layer
        }
        selectedLayerID = layers.first?.id
    }

    private func exportPNG() {
        if let img = ExportService.exportPNG(
            view: BindruneCanvasView(layers: .constant(layers), selectedLayerID: .constant(nil)),
            size: CGSize(width: 1024, height: 1024)
        ) {
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        }
    }

    private func addRuneQuickPick() {
        // simple: ajoute Algiz
        if layers.count < 5 {
            layers.append(.init(runeKey: "algiz", glyph: "ᛉ", scale: 0.9))
        }
    }
}

// MARK: - Tags

struct FlowIntentTags: View {
    @Binding var selected: Set<IntentTag>

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 110), spacing: 8)],
            spacing: 8
        ) {
            ForEach(IntentTag.allCases, id: \.self) { tag in
                intentChip(tag)
            }
        }
    }

    @ViewBuilder
    private func intentChip(_ tag: IntentTag) -> some View {
        let isSelected = selected.contains(tag)

        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            if isSelected { selected.remove(tag) } else { selected.insert(tag) }
        } label: {
            Text(tag.rawValue.capitalized)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .black : .primary)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? tag.accent.opacity(0.85) : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isSelected ? tag.accent : Color.secondary.opacity(0.35),
                            lineWidth: isSelected ? 2 : 1
                        )
                )
                // OK ici (petit élément). Le yoyo vient du halo central, pas des chips.
                .pulsingHalo(color: tag.accent, active: isSelected)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.18), value: isSelected)
    }
}

//
//  RuneDetailView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct RuneDetailView: View {
    let rune: RuneDefinition
    let aettName: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text(rune.glyph).font(.system(size: 72))
                    VStack(alignment: .leading) {
                        Text(rune.name).font(.largeTitle).bold()
                        Text(aettName).foregroundStyle(.secondary)
                    }
                    Spacer()
                }

                GroupBox("Son") {
                    Text(rune.sound).font(.title2)
                }

                GroupBox("Signification symbolique") {
                    FlowTags(tags: rune.keywords)
                }
            }
            .padding()
        }
        .navigationTitle(rune.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FlowTags: View {
    let tags: [String]
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 8)], spacing: 8) {
            ForEach(tags, id: \.self) { t in
                Text(t)
                    .font(.subheadline)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
            }
        }
    }
}


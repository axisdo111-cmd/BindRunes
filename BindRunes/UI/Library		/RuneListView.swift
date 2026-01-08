//
//  RuneListView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct RuneListView: View {
    @StateObject private var store = RuneLibraryStore()

    var body: some View {
        NavigationStack {
            Group {
                if let lib = store.library {
                    List {
                        ForEach(lib.aetts) { aett in
                            Section(aett.name) {
                                ForEach(aett.runes) { rune in
                                    NavigationLink {
                                        RuneDetailView(rune: rune, aettName: aett.name)
                                    } label: {
                                        HStack(spacing: 12) {
                                            Text(rune.glyph).font(.system(size: 32))
                                            VStack(alignment: .leading) {
                                                Text(rune.name).font(.headline)
                                                Text("Son: \(rune.sound)")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    ContentUnavailableView("Librairie introuvable",
                                           systemImage: "questionmark.folder")
                }
            }
            .navigationTitle("Lexique Futhark")
        }
        .onAppear { store.load() }
    }
}

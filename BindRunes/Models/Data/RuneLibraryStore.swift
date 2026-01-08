//
//  RuneLibraryStore.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import Foundation

@MainActor
final class RuneLibraryStore: ObservableObject {
    @Published private(set) var library: RuneLibrary?

    func load() {
        guard let url = Bundle.main.url(forResource: "runes_elder_futhark", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(RuneLibrary.self, from: data)
        else { return }

        library = decoded
        print("JSON chargé :", decoded.system)
        print("Nombre d’Aetts :", decoded.aetts.count)

    }

    var allRunes: [RuneDefinition] {
        library?.aetts.flatMap { $0.runes } ?? []
    }
}


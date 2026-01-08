//
//  IntentGenerator.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import Foundation

struct IntentRequest {
    var tags: [IntentTag]
    var intensity: Double // 0..1
    var maxRunes: Int
}

enum IntentGenerator {
    static func suggestRuneKeys(for req: IntentRequest) -> [String] {
        var candidates: [String] = []

        func add(_ keys: [String]) { candidates.append(contentsOf: keys) }

        for t in req.tags {
            switch t {
            case .finance:
                add(["fehu","jera","othala","mannaz","ansuz"])
            case .success:
                add(["sowilo","tiwaz","raidho","jera"])
            case .protection:
                add(["algiz","thurisaz","eihwaz"])
            case .creativity:
                add(["kenaz","ansuz","dagaz"])
            case .love:
                add(["gebo","wunjo","berkano","laguz"])
            case .healing:
                add(["berkano","laguz","uruz"])
            case .clarity:
                add(["sowilo","ansuz","dagaz"])
            case .change:
                add(["dagaz","hagalaz","raidho"])
            case .discipline:
                add(["nauthiz","tiwaz","isa","jera"])
            case .intuition:
                add(["laguz","perthro","ansuz"])
            }
        }

        // Filtrage simple: éviter combos instables selon contexte "safe"
        // ex: si finance -> on évite hagalaz/nauthiz par défaut
        if req.tags.contains(.finance) {
            candidates.removeAll { ["hagalaz","nauthiz","thurisaz"].contains($0) }
        }

        // Dédup + pick
        var unique: [String] = []
        for k in candidates where !unique.contains(k) { unique.append(k) }
        return Array(unique.prefix(max(2, min(req.maxRunes, unique.count))))
    }
}

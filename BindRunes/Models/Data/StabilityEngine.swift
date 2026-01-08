//
//  StabilityEngine.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

struct StabilityReport {
    var score: Int
    var warnings: [String]
    var suggestions: [String]
}

enum StabilityEngine {
    static func evaluate(keys: [String], contextTags: Set<IntentTag>) -> StabilityReport {
        var score = 90
        var warnings: [String] = []
        var suggestions: [String] = []

        let set = Set(keys)

        // 1) Chaos
        if set.contains("hagalaz") && set.contains("thurisaz") {
            score -= 30
            warnings.append("Hagalaz + Thurisaz : rupture + agressivité → instable.")
            suggestions.append("Ajoute un tampon : Jera (cycle) ou Mannaz (lucidité).")
        }

        // 2) Blocage
        if set.contains("isa") && (set.contains("laguz") || set.contains("raidho") || set.contains("ehwaz")) {
            score -= 20
            warnings.append("Isa + flux (Laguz/Raidho/Ehwaz) peut figer l’objectif.")
            suggestions.append("Remplace Isa par Jera si tu veux une progression.")
        }

        // 3) Amplification risquée
        if set.contains("sowilo") && set.contains("uruz") && !set.contains("jera") && !set.contains("othala") {
            score -= 15
            warnings.append("Sowilo + Uruz amplifie l’énergie sans cadre.")
            suggestions.append("Ajoute Othala (cadre) ou Jera (tempo).")
        }

        // 4) Contrainte (souvent mauvaise en finance)
        if contextTags.contains(.finance) && set.contains("nauthiz") {
            score -= 18
            warnings.append("Nauthiz en contexte finance : peut renforcer le sentiment de manque.")
            suggestions.append("Préférer Othala (sécurité) ou Mannaz (réseau/stratégie).")
        }

        // 5) Trop de runes (bruit)
        if keys.count >= 5 {
            score -= 8
            warnings.append("5 runes : plus complexe → intention moins nette.")
            suggestions.append("Essaye 3 runes (1 objectif + 2 tampons).")
        }

        score = max(0, min(100, score))
        return .init(score: score, warnings: warnings.uniqued(), suggestions: suggestions.uniqued())
    }
}

private extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var s = Set<Element>()
        return filter { s.insert($0).inserted }
    }
}

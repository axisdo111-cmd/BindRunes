//
//  SnapEngine.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import CoreGraphics

struct SnapConfig {
    var enabled: Bool = true
    var snapToCenter: Bool = true
    var tolerance: Double = 10
}

enum GuideLine: Hashable {
    case centerVertical
    case centerHorizontal
}

enum SnapEngine {

    static func snapOffset(
        x: Double,
        y: Double,
        in size: CGSize,
        cfg: SnapConfig
    ) -> (Double, Double, [GuideLine]) {

        guard cfg.enabled else { return (x, y, []) }

        var outX = x
        var outY = y
        var guides: [GuideLine] = []

        if cfg.snapToCenter {
            if abs(outX) < cfg.tolerance {
                outX = 0
                guides.append(.centerVertical)
            }
            if abs(outY) < cfg.tolerance {
                outY = 0
                guides.append(.centerHorizontal)
            }
        }

        return (outX, outY, guides)
    }
}

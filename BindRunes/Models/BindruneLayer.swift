//
//  BindruneLayer.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import Foundation

struct BindruneLayer: Codable, Identifiable, Hashable {
    var id = UUID()
    var runeKey: String
    var glyph: String

    var x: Double = 0
    var y: Double = 0
    var rotation: Double = 0
    var scale: Double = 1
    var isMirrored: Bool = false
    var opacity: Double = 1
}


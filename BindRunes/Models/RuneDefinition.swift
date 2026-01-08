//
//  RuneDefinition.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import Foundation

struct RuneLibrary: Decodable {
    let version: String
    let system: String
    let aetts: [Aett]
}

struct Aett: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let runes: [RuneDefinition]
}

struct RuneDefinition: Decodable, Identifiable, Hashable {
    let key: String
    let glyph: String
    let name: String
    let sound: String
    let keywords: [String]

    var id: String { key }
}


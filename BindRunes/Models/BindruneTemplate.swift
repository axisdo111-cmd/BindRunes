//
//  BindruneTemplate.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import Foundation

struct BindruneTemplate: Identifiable {
    let id = UUID()
    let name: String
    let runeKeys: [String]
    let description: String
}

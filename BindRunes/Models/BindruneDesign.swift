//
//  BindruneDesign.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import Foundation

struct BindruneDesign: Identifiable, Codable {
    var id = UUID()
    var title: String
    var intent: String
    var layers: [BindruneLayer]
}

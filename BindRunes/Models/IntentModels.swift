//
//  IntentModels.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

enum IntentTag: String, CaseIterable, Hashable {
    case finance
    case protection
    case success
    case creativity
    case love
    case healing
    case clarity
    case change
    case discipline
    case intuition
}

extension IntentTag {
    var accent: Color {
        switch self {
        case .finance: return .yellow
        case .success: return .orange
        case .protection: return .red
        case .creativity: return .purple
        case .love: return .pink
        case .healing: return .green
        case .clarity: return .cyan
        case .change: return .indigo
        case .discipline: return .brown
        case .intuition: return .blue
        }
    }
}

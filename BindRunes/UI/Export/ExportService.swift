//
//  ExportService.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI
import UIKit

@MainActor
enum ExportService {
    static func exportPNG<V: View>(view: V, size: CGSize) -> UIImage? {
        let renderer = ImageRenderer(content: view.frame(width: size.width, height: size.height))
        renderer.scale = 2.0
        return renderer.uiImage
    }
}

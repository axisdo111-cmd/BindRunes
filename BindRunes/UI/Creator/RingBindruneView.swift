//
//  RingBindruneView.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

struct RingBindruneView: View {
    let ringImageName: String
    @Binding var layers: [BindruneLayer]
    @Binding var selectedLayerID: UUID?

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)

            ZStack {
                Image(ringImageName)
                    .resizable()
                    .scaledToFit()

                // zone intérieure (à ajuster)
                BindruneCanvasView(layers: $layers, selectedLayerID: $selectedLayerID)
                    .frame(width: size * 0.66, height: size * 0.66)
                    .clipShape(Circle())
            }
            .frame(width: size, height: size)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

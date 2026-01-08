//
//  RunePathFactory.swift
//  BindRunes
//
//  Created by Daniel PHAM-LE-THANH on 07/01/2026.
//

import SwiftUI

enum RunePathFactory {
    static func path(for key: String, in rect: CGRect) -> Path? {
        switch key {
        case "fehu": return fehu(in: rect)
        case "jera": return jera(in: rect)
        case "othala": return othala(in: rect)
        default: return nil
        }
    }

    private static func fehu(in r: CGRect) -> Path {
        var p = Path()
        let x = r.midX - r.width*0.12
        let top = CGPoint(x: x, y: r.minY + r.height*0.12)
        let bot = CGPoint(x: x, y: r.maxY - r.height*0.12)
        p.move(to: top); p.addLine(to: bot)

        // 2 branches
        p.move(to: CGPoint(x: x, y: r.midY - r.height*0.18))
        p.addLine(to: CGPoint(x: r.midX + r.width*0.18, y: r.midY - r.height*0.32))

        p.move(to: CGPoint(x: x, y: r.midY + r.height*0.02))
        p.addLine(to: CGPoint(x: r.midX + r.width*0.18, y: r.midY - r.height*0.12))
        return p
    }

    private static func jera(in r: CGRect) -> Path {
        var p = Path()
        // Deux chevrons opposés (cycle)
        let a = CGPoint(x: r.midX - r.width*0.18, y: r.midY - r.height*0.18)
        let b = CGPoint(x: r.midX, y: r.midY - r.height*0.32)
        let c = CGPoint(x: r.midX + r.width*0.18, y: r.midY - r.height*0.18)

        p.move(to: a); p.addLine(to: b); p.addLine(to: c)

        let d = CGPoint(x: r.midX - r.width*0.18, y: r.midY + r.height*0.18)
        let e = CGPoint(x: r.midX, y: r.midY + r.height*0.32)
        let f = CGPoint(x: r.midX + r.width*0.18, y: r.midY + r.height*0.18)
        p.move(to: d); p.addLine(to: e); p.addLine(to: f)
        return p
    }

    private static func othala(in r: CGRect) -> Path {
        var p = Path()
        // losange + "pieds"
        let top = CGPoint(x: r.midX, y: r.minY + r.height*0.12)
        let right = CGPoint(x: r.midX + r.width*0.22, y: r.midY)
        let bot = CGPoint(x: r.midX, y: r.maxY - r.height*0.22)
        let left = CGPoint(x: r.midX - r.width*0.22, y: r.midY)

        p.move(to: top); p.addLine(to: right); p.addLine(to: bot); p.addLine(to: left); p.closeSubpath()

        // pieds
        p.move(to: left); p.addLine(to: CGPoint(x: r.midX - r.width*0.30, y: r.maxY - r.height*0.10))
        p.move(to: right); p.addLine(to: CGPoint(x: r.midX + r.width*0.30, y: r.maxY - r.height*0.10))
        return p
    }
}

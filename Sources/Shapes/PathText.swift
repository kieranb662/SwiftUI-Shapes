//  Created by Kieran Brown on 3/25/20.
//  Copyright © 2020 BrownandSons. All rights reserved.


import SwiftUI

public struct PathText: Shape {
    public init() {}
    public func path(in rect: CGRect) -> Path {
        Path { path in
            let w = rect.width/0.7
            let h = rect.height
            // P
            path.move(to: CGPoint(x: 0*w, y: 0.4*h))
            path.addCurve(to: CGPoint(x: 0*w, y: 0.029*h), control1: CGPoint(x: 0.18*w, y: 0.508*h), control2: CGPoint(x: 0.179*w, y: -0.144*h))
            path.addLine(to: CGPoint(x: 0*w, y: h))
            // A
            path.move(to: CGPoint(x: 0.125*w, y: h))
            path.addLine(to: CGPoint(x: 0.175*w, y: 0.5*h))
            path.addLine(to: CGPoint(x: 0.275*w, y: 0.5*h))
            path.addLine(to: CGPoint(x: 0.225*w, y: 0*h))
            path.addLine(to: CGPoint(x: 0.175*w, y: 0.5*h))
            path.addLine(to: CGPoint(x: 0.275*w, y: 0.5*h))
            path.addLine(to: CGPoint(x: 0.325*w, y: h))
            // T
            path.move(to: CGPoint(x: 0.425*w, y: h))
            path.addLine(to: CGPoint(x: 0.425*w, y: 0.0*h))
            path.addLine(to: CGPoint(x: 0.325*w, y: 0.0*h))
            path.addLine(to: CGPoint(x: 0.525*w, y: 0.0*h))
            // H
            path.move(to: CGPoint(x: 0.55*w, y: h))
            path.addLine(to: CGPoint(x: 0.55*w, y: 0.0*h))
            path.addLine(to: CGPoint(x: 0.55*w, y: 0.500*h))
            path.addLine(to: CGPoint(x: 0.7*w, y: 0.500*h))
            path.addLine(to: CGPoint(x: 0.7*w, y: 0*h))
            path.addLine(to: CGPoint(x: 0.7*w, y: h))

        }
    }
}

//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.

import SwiftUI

public struct PolarGrid: Shape {
    public var rCount: Int
    public var thetaCount: Int
    public init(rCount: Int, thetaCount: Int) {
        self.rCount = rCount
        self.thetaCount = thetaCount
    }

    public func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let maxRadius =  w > h ? w/2 : h/2
        let thetaIncrement = 2*CGFloat.pi/(CGFloat(thetaCount) + 1)
        let radialIncrement = maxRadius/(CGFloat(rCount) + 1)
        return Path { path in
            // for loop creates lines intersecting the center of the circles dividing the graph into subsections.
            for i in 0...(thetaCount + 1) {
                let x = 2 * maxRadius
                let y = 2 * maxRadius * CGFloat(tan(CGFloat(i) * thetaIncrement))
                let adjustedPoint = CGPoint(x: x + rect.midX, y: y + rect.midY)
                let adjustedEnd = CGPoint(x: rect.midX - x, y: rect.midY - y)
                path.move(to: adjustedPoint)
                path.addLine(to: adjustedEnd)
            }
            // for loop generates circles of increasing radius.
            for i in 0...(self.rCount + 1) {
                let radius = radialIncrement * CGFloat(i)
                let rect = CGRect(x: rect.midX-radius, y: rect.midY-radius, width: radius*2, height: radius*2)
                path.addEllipse(in: rect, transform: .identity)
            }
        }
    }
}


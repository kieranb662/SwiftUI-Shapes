//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.


import SwiftUI

public struct Pentagon: Shape {
    public init() {}
    var insetAmount: CGFloat = 0
    public func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        return Path { path in
            path.move(to: CGPoint(x: w/2, y: insetAmount))
            path.addLine(to: CGPoint(x: insetAmount, y: h/2))
            path.addLine(to: CGPoint(x: insetAmount, y: h - insetAmount))
            path.addLine(to: CGPoint(x: w - insetAmount, y: h - insetAmount))
            path.addLine(to: CGPoint(x: w - insetAmount, y: h/2))
            path.closeSubpath()
        }
    }
}

extension Pentagon: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

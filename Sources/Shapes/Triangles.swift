//  Created by Kieran Brown on 3/21/20.
//  Copyright © 2020 BrownandSons. All rights reserved.

import SwiftUI

public struct Triangle: Shape {
    /// Creates an upside down isosceles triangle that is the height and width of its containing rectangle. The left and right sides are congruent.
    public init() {}

    var insetAmount: CGFloat = 0

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: insetAmount, y: insetAmount))
            path.addLine(to: .init(x: rect.size.width/2, y: rect.size.height-insetAmount))
            path.addLine(to: .init(x: rect.width-insetAmount, y: insetAmount))
            path.closeSubpath()
        }
    }
}

extension Triangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

public struct OpenTriangle: Shape {
    public init() {}
    public func path(in rect: CGRect) -> Path {
        Path { (path) in
            let w = rect.width
            let h = rect.height
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: w, y: h/2))
            path.addLine(to: CGPoint(x: 0, y: h))
        }
    }
}

public struct RightTriangle: Shape {
    public init() {}
    public func path(in rect: CGRect) -> Path {
        Path { (path) in
            let w = rect.width
            let h = rect.height

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: w, y: h))
            path.closeSubpath()
        }
    }
}

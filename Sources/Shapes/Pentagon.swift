//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.


import SwiftUI

public struct Pentagon: Shape {
    /// Creates a square bottomed pentagon.
    public init() {}
    
    var insetAmount: CGFloat = 0
    
    public func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height

        return Path { path in
            path.move(to:    CGPoint(x: w/2, y:   0))
            path.addLine(to: CGPoint(x:   0, y: h/2))
            path.addLine(to: CGPoint(x:   0, y:   h))
            path.addLine(to: CGPoint(x:   w, y:   h))
            path.addLine(to: CGPoint(x:   w, y: h/2))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension Pentagon: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

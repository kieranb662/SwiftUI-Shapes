// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//

import SwiftUI

public struct FlashlightShape: Shape {
    private var insetAmount: CGFloat = 0
    
    /// Creates a shape that looks like an upsidedown flashlight.
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height

        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: 0, y: 4*h/5))
            
            path.addCurve(to:       CGPoint(x: w/5, y:   h/2),
                          control1: CGPoint(x:   0, y: 2*h/3),
                          control2: CGPoint(x: w/5, y: 2*h/3))
            
            path.addLine(to: CGPoint(x:   w/5, y:   0))
            path.addLine(to: CGPoint(x: 4*w/5, y:   0))
            path.addLine(to: CGPoint(x: 4*w/5, y: h/2))
            
            path.addCurve(to:       CGPoint(x:     w, y: 4*h/5),
                          control1: CGPoint(x: 4*w/5, y: 2*h/3),
                          control2: CGPoint(x:     w, y: 2*h/3))
            
            path.addLine(to: CGPoint(x: w, y: h))

            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension FlashlightShape: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

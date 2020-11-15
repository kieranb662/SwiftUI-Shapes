// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

public struct Trapezoid: Shape {
    private var insetAmount: CGFloat = 0
    private var baseRatio: CGFloat
    private var curvature: CGFloat
    
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(baseRatio, curvature) }
        set {
            self.baseRatio = newValue.first
            self.curvature = newValue.second
        }
    }
    
    /// Creates a trapezoid with a large bottom and small top
    /// - Parameters:
    ///   - baseRatio: The ratio of the top's length/bottom's length. Any number less than 0 will be treated as 0, which looks like a triangle.
    ///   - curvature: a postive value makes the left and right edges curve inward. a negative value makes them curve outward. 0 is a straight line.
    public init(baseRatio: CGFloat, curvature: CGFloat = 0) {
        self.baseRatio = baseRatio
        self.curvature = curvature
    }
    
    public func path(in rect: CGRect) -> Path {
//        let ratio = max(min(baseRatio, 1), 0)
        let ratio = max(baseRatio, 0)
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        let d = (w-w*ratio)/2
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addQuadCurve(to: CGPoint(x: d, y: 0),
                              control: CGPoint(x: (w/2 - d/2)*curvature + d/2, y: h/2))
            path.addLine(to: CGPoint(x: w-d, y: 0))
            path.addQuadCurve(to: CGPoint(x: w, y: h),
                              control:  CGPoint(x: (d/2 - w/2)*curvature + w - d/2, y: h/2))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension Trapezoid: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

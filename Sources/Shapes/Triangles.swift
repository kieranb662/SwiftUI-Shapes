//  Created by Kieran Brown on 3/21/20.
//  Copyright © 2020 BrownandSons. All rights reserved.

import SwiftUI

public struct Triangle: Shape {
    private var insetAmount: CGFloat = 0
    var leftEdgeCurvature: CGFloat
    var rightEdgeCurvature: CGFloat
    var bottomEdgeCurvature: CGFloat
    
    /// Creates a Triangle with congreunt left and right edges.
    /// If the containing rectangle is a square then the Triangle will be equilateral,
    ///
    /// - Parameters:
    ///   - leftEdgeCurvature: The curvature value of the left edge positive values curve the edge inwards while postive values curve outwards
    ///   - rightEdgeCurvature: The curvature value of the right edge positive values curve the edge inwards while postive values curve outwards
    ///   - bottomEdgeCurvature: The curvature value of the top edge positive values curve the edge inwards while postive values curve outwards
    public init(leftEdgeCurvature: CGFloat = 0,
                rightEdgeCurvature: CGFloat = 0,
                bottomEdgeCurvature: CGFloat = 0) {
        self.leftEdgeCurvature = leftEdgeCurvature
        self.rightEdgeCurvature = rightEdgeCurvature
        self.bottomEdgeCurvature = bottomEdgeCurvature
    }
    
    public func path(in rect: CGRect) -> Path {
        let insetRect: CGRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let w = insetRect.width
        let h = insetRect.height
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: h))
            path.addQuadCurve(to: CGPoint(x: w/2, y: 0),
                              control: CGPoint(x: w*leftEdgeCurvature/4 + w/4, y: h/2))
            path.addQuadCurve(to: CGPoint(x: w, y: h),
                              control: CGPoint(x: 3*w/4 - w*rightEdgeCurvature/4, y: h/2))
            path.addQuadCurve(to: CGPoint(x: 0, y: h),
                              control: CGPoint(x: w/2, y: h - h*bottomEdgeCurvature/4))
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension Triangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

extension Triangle {
    public init(curvature: CGFloat = 0) {
        self.leftEdgeCurvature = curvature
        self.rightEdgeCurvature = curvature
        self.bottomEdgeCurvature = curvature
    }
}

extension Triangle {
    /// A Triangle that is curved to look like the tip of a bullet
    public static func bulletTip() -> Triangle {
        Triangle(leftEdgeCurvature: -1,
                 rightEdgeCurvature: -1,
                 bottomEdgeCurvature: 0)
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

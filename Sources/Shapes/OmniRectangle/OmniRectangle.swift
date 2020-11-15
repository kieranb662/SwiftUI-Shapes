// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//


import SwiftUI

public struct OmniRectangle: Shape {
    private var insetAmount: CGFloat = 0
    private var cornerStyles: CornerStyles
    private var edgeStyles: EdgeStyles
    
    // TODO: Add in the animation data for the corner styles
    public var animatableData: AnimatablePair<AnimatablePair<CGFloat, CGFloat>,
                                              AnimatablePair<CGFloat, CGFloat>> {
        get {
            AnimatablePair(
                AnimatablePair(edgeStyles.leftCurvature, edgeStyles.topCurvature),
                AnimatablePair(edgeStyles.rightCurvature, edgeStyles.bottomCurvature)
            )
        }
        set {
            edgeStyles[keyPath: \.leftCurvature] = newValue.first.first
            edgeStyles[keyPath: \.topCurvature] = newValue.first.second
            edgeStyles[keyPath: \.rightCurvature] = newValue.second.first
            edgeStyles[keyPath: \.bottomCurvature] = newValue.second.second
        }
    }
    
    public init(corners: CornerStyles = .allSquare(), edges: EdgeStyles = .allFlat()) {
        self.cornerStyles = corners
        self.edgeStyles = edges
    }
    
    public init(topLeft: CornerStyle, topRight: CornerStyle, bottomLeft: CornerStyle, bottomRight: CornerStyle) {
        self.cornerStyles = CornerStyles(topLeft: topLeft,
                                         topRight: topRight,
                                         bottomLeft: bottomLeft,
                                         bottomRight: bottomRight)
        self.edgeStyles = .allFlat()
    }
    
    public init(leftEdgeCurvature: CGFloat, topEdgeCurvature: CGFloat, rightEdgeCurvature: CGFloat, bottomEdgeCurvature: CGFloat) {
        self.edgeStyles = EdgeStyles(leftCurvature: leftEdgeCurvature,
                                     topCurvature: topEdgeCurvature,
                                     rightCurvature: rightEdgeCurvature,
                                     bottomCurvature: bottomEdgeCurvature)
        
        self.cornerStyles = .allSquare()
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
            let (width, height) = (insetRect.width, insetRect.height)
            let control = CGPoint(x: width/2, y: edgeStyles.topCurvature*height/2)
            
            cornerStyles.topRight.applyTopRight(&path, width, height)
            cornerStyles.bottomRight.applyBottomRight(&path, width, height, edgeStyles.rightCurvature)
            cornerStyles.bottomLeft.applyBottomLeft(&path, width, height, edgeStyles.bottomCurvature)
            cornerStyles.topLeft.applyTopLeft(&path, width,height, edgeStyles.leftCurvature)
            
            let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
            
            switch cornerStyles.topRight {
            case .round(let radius):
                path.addQuadCurve(to: CGPoint(x: width - checkMin(radius), y: 0), control: control)
            case .cut(let depth):
                path.addQuadCurve(to: CGPoint(x: width - checkMin(depth), y: 0), control: control)
            case .square:
                path.addQuadCurve(to: CGPoint(x: width, y: 0), control: control)
            }
            
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension OmniRectangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

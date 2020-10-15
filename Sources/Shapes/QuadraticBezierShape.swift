//
//  QuadraticBezierShape.swift
//  UX Masterclass
//
//  Created by Kieran Brown on 7/11/20.
//  Copyright © 2020 Kieran Brown. All rights reserved.
//

import SwiftUI

public struct QuadraticBezierShape: Shape {
    public var start: CGPoint
    public var control: CGPoint
    public var end: CGPoint
    public init(start: CGPoint, control: CGPoint, end: CGPoint) {
        self.start = start
        self.control = control
        self.end = end
    }

    public var animatableData: AnimatablePair<AnimatablePair<CGPoint, CGPoint>, CGPoint> {
        get { AnimatablePair(AnimatablePair(start, end), control)}
        set {
            start = newValue.first.first
            control = newValue.second
            end = newValue.first.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: self.start)
            path.addQuadCurve(to: self.end, control: self.control)
        }
    }
}

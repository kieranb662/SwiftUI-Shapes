//
//  CubicBezierShape.swift
//  UX Masterclass
//
//  Created by Kieran Brown on 7/11/20.
//  Copyright © 2020 Kieran Brown. All rights reserved.
//

import SwiftUI

public struct CubicBezierShape: Shape {
    public var start: CGPoint
    public var control1: CGPoint
    public var control2: CGPoint
    public var end: CGPoint
    public init(start: CGPoint, control1: CGPoint, control2: CGPoint, end: CGPoint) {
        self.start = start
        self.control1 = control1
        self.control2 = control2
        self.end = end
    }

    public var animatableData: AnimatablePair<AnimatablePair<CGPoint, CGPoint>, AnimatablePair<CGPoint, CGPoint>> {
        get { AnimatablePair(AnimatablePair(start, end), AnimatablePair(control1, control2))}
        set {
            start = newValue.first.first
            control1 = newValue.second.first
            control2 = newValue.second.second
            end = newValue.first.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: self.start)
            path.addCurve(to: self.end,control1: self.control1, control2: self.control2)
        }
    }
}


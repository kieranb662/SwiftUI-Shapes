//
//  CircularArc.swift
//  UX Masterclass
//
//  Created by Kieran Brown on 7/11/20.
//  Copyright © 2020 Kieran Brown. All rights reserved.
//

import SwiftUI

public struct CircularArc: Shape {
    public var start: CGPoint
    public var center: CGPoint
    public var radius: CGFloat
    public var startAngle: Angle
    public var endAngle: Angle
    public var clockwise: Bool

    public init(start: CGPoint, center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle, clockwise: Bool) {
        self.start = start
        self.center = center
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.clockwise = clockwise

    }

    public var animatableData: AnimatablePair<AnimatablePair<AnimatablePair<CGPoint, CGPoint>, AnimatablePair<Double, Double>>, CGFloat> {
        get {AnimatablePair(AnimatablePair(AnimatablePair(start, center), AnimatablePair(startAngle.degrees, endAngle.degrees)), radius)}
        set {
            self.start = newValue.first.first.first
            self.center = newValue.first.first.second
            self.radius = newValue.second
            self.startAngle = .init(degrees: newValue.first.second.first)
            self.endAngle = .init(degrees: newValue.first.second.second)
        }
    }


    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: self.start)
            path.addArc(center: self.center,
                        radius: self.radius,
                        startAngle: self.startAngle,
                        endAngle: self.endAngle,
                        clockwise: self.clockwise)

        }
    }
}

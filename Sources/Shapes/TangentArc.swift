//
//  TangentArc.swift
//  UX Masterclass
//
//  Created by Kieran Brown on 7/11/20.
//  Copyright © 2020 Kieran Brown. All rights reserved.
//

import SwiftUI

public struct TangentArc: Shape {
    public var start: CGPoint
    public var tangent1End: CGPoint
    public var tangent2End: CGPoint
    public var radius: CGFloat

    public init(start: CGPoint, tangent1End: CGPoint, tangent2End: CGPoint, radius: CGFloat) {
        self.start = start
        self.tangent1End = tangent1End
        self.tangent2End = tangent2End
        self.radius = radius
    }

    public var animatableData: AnimatablePair<AnimatablePair<CGPoint, CGFloat>,
                                              AnimatablePair<CGPoint, CGPoint>> {
        get {
            AnimatablePair(
                AnimatablePair(self.start, self.radius),
                AnimatablePair(self.tangent1End, self.tangent2End)
            )
        }
        set {
            self.start = newValue.first.first
            self.radius = newValue.first.second
            self.tangent1End = newValue.second.first
            self.tangent2End = newValue.second.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: start)
            path.addArc(tangent1End: tangent1End, tangent2End: tangent2End, radius: radius)
        }
    }
}

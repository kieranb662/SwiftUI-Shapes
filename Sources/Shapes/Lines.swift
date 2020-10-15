//
//  File.swift
//  
//  Created by Kieran Brown on 3/21/20.
//  Copyright © 2020 BrownandSons. All rights reserved.

import SwiftUI

public struct Line: Shape {
    public var from: CGPoint
    public var to: CGPoint
    public init(from: CGPoint, to: CGPoint) {
        self.from = from
        self.to = to
    }
    public var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get { AnimatablePair(from, to) }
        set {
            from = newValue.first
            to = newValue.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: self.from)
            path.addLine(to: self.to)
        }
    }
}

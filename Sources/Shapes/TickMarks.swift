//
//  TickMarks.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct TickMarks: Shape {
    public var spacing: CGFloat
    public var ticks: Int
    public init(spacing: CGFloat, ticks: Int) {
        self.spacing = spacing
        self.ticks = ticks
    }
    func determineHeight(_ i: Int) -> CGFloat {
        if i%100 == 0 {
            return 1
        } else if i%10 == 0 {
            return 0.75
        }else if i%5 == 0 {
            return 0.5
        } else {
            return 0.25
        }
    }
    public func path(in rect: CGRect) -> Path {
        Path { path in
            for i in 0...ticks {
                path.move(to: CGPoint(x: CGFloat(i)*spacing, y: 0))
                path.addLine(to: CGPoint(x: CGFloat(i)*spacing, y: rect.height*self.determineHeight(i)))
            }
        }
    }
}



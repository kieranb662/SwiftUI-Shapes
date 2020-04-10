//
//  Pentagon.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct Pentagon: Shape {
    public init() {}
    public func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        return Path { path in
            path.move(to: CGPoint(x: w/2, y: 0))
            path.addLine(to: CGPoint(x: 0, y: h/2))
            path.addLine(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: w, y: h))
            path.addLine(to: CGPoint(x: w, y: h/2))
            path.closeSubpath()
        }
    }
}



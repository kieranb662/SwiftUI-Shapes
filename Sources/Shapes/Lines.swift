//
//  File.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import SwiftUI
import CGExtender

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
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
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)

        }
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct HorizontalLine: Shape {
    public init() {
        
    }
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        }
    }
}

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct VerticalLine: Shape {
    public init() {
        
    }
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        }
    }
}

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


// MARK: - Adaptive Line
/// # Adaptive Line
///
/// This shape creates a line centered inside of and constrained by its bounding box.
/// The end points of the line are the points of intersection of an infinitely long angled line and the container rectangle
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct AdaptiveLine: Shape {
    public var angle: Angle
    public var animatableData: Angle {
        get {
            self.angle
        }
        set {
            self.angle = newValue
        }
    }
    public init(angle: Angle) {
        self.angle = angle
    }
    
    public func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let big: CGFloat = 5000000
        
        let x1 = w/2 + big*CGFloat(cos(self.angle.radians))
        let y1 = h/2 + big*CGFloat(sin(self.angle.radians))
        let x2 = w/2 - big*CGFloat(cos(self.angle.radians))
        let y2 = h/2 - big*CGFloat(sin(self.angle.radians))
        
        let points = lineRectIntersection(x1, y1, x2, y2, 0, 0, w, h)
        if points.count < 2 {
            return Path { p in
                p.move(to: CGPoint(x: 0, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.width, y: rect.midY))
            }
        }
        
        return Path { p in
            p.move(to: points[0])
            p.addLine(to: points[1])
        }
    }
}

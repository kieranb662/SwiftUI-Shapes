//
//  Triangles.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        Path { (path) in
            let w = rect.width
            let h = rect.height
            
            path.move(to: CGPoint(x: w/2, y: 0))
            path.addLine(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: w, y: h))
            path.closeSubpath()
            
        }
    }
}
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct OpenTriangle: Shape {
    public func path(in rect: CGRect) -> Path {
        Path { (path) in
            let w = rect.width
            let h = rect.height
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: w, y: h/2))
            path.addLine(to: CGPoint(x: 0, y: h))
            
        }
    }
}
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct RightTriangle: Shape {
    public func path(in rect: CGRect) -> Path {
        Path { (path) in
            let w = rect.width
            let h = rect.height
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: h))
            path.addLine(to: CGPoint(x: w, y: h))
            path.closeSubpath()
        }
    }
}

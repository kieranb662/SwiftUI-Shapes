//
//  File.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct InfinitySymbol: Shape {
    public func path(in rect: CGRect) -> Path {
        return InfinitySymbol.createInfinityPath(in: rect)
    }

    public static func createInfinityPath(in rect: CGRect) -> Path {
        let height = rect.size.height
        let width = rect.size.width
        let heightFactor = height/4
        let widthFactor = width/4

        var path = Path()

        path.move(to: CGPoint(x:widthFactor, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor), control1: CGPoint(x:0, y: heightFactor * 3), control2: CGPoint(x:0, y: heightFactor))

        path.move(to: CGPoint(x:widthFactor, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3), control1: CGPoint(x:widthFactor * 2, y: heightFactor), control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))

        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor), control1: CGPoint(x:widthFactor * 4 + 5, y: heightFactor * 3), control2: CGPoint(x:widthFactor * 4 + 5, y: heightFactor))

        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor * 3), control1: CGPoint(x:widthFactor * 2, y: heightFactor), control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))

        return path
    }
}

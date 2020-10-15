//
//  FoldableShape.swift
//  Shapes Examples
//
//  Created by Kieran Brown on 4/14/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI

extension Path {
    /// The array of `Path.Elements` describing the path
    var elements: [Path.Element] {
        var temp = [Path.Element]()
        forEach { (element) in
            temp.append(element)
        }
        return temp
    }

    /// Returns the starting point of the path
    func getStartPoint() -> CGPoint? {
        if isEmpty {
            return nil
        }

        guard let first = elements.first(where: {
            switch $0 {
            case .move(_):
                return true
            default:
                return false
            }
        }) else {
            return nil
        }

        switch first {
        case .move(let to):
            return to
        default:
            return nil
        }
    }

    /// Returns the last point on the path rom the last curve command
    func getEndPoint() -> CGPoint? {
        if isEmpty {
            return nil
        }

        guard let last = elements.reversed().first(where: { (element) in
            switch element {
            case .line(_), .quadCurve(_, _), .curve(_, _, _):
                return true
            case .move(_), .closeSubpath:
                return false
            }
        }) else {
            return nil
        }

        switch last {
        case .line(let to), .quadCurve(let to, _), .curve(let to, _, _):
            return to
        default:
            return nil

        }
    }
}

/// # Foldable Shape
/// A Shape which can be folded over itself.
public struct FoldableShape<S: Shape>: View {
    var shape: S
    var mainColor: Color
    var foldColor: Color
    var fraction: CGFloat

    public init(_ shape: S, fraction: CGFloat, mainColor: Color = .yellow, foldColor: Color = .pink) {
        self.shape = shape
        self.fraction = fraction
        self.mainColor = mainColor
        self.foldColor = foldColor
    }

    /// Function reflects a point over the line that crosses between r1 and r2
    private func reflect(_ r1: CGPoint, _ r2: CGPoint, _ p: CGPoint) -> CGPoint {
        let a = (r2.y-r1.y)
        let b = -(r2.x-r1.x)
        let c = -a*r1.x - b*r1.y
        let magnitude = sqrt(a*a + b*b)
        let ai = a/magnitude
        let bi = b/magnitude
        let ci = c/magnitude

        let d = ai*p.x + bi*p.y + ci
        let x = p.x - 2*ai*d
        let y = p.y - 2*bi*d
        return CGPoint(x: x, y: y)
    }

    /// Creates the folded portion of the path given the large and small fractions which define line that the portion is folded over.
    /// Procedure:
    ///     1. Get the fraction of the path that will serve as the folded peice
    ///     2. Get the start and end points of that path
    ///     3. Create the reflected path by Iterating through all pathFractions elements, reflecting any curve across the line defined by the start and end points.
    private func makeFold(path: Path) -> some View {
        let pathFraction = path.trimmedPath(from: fraction, to: 1)
        let start = pathFraction.getStartPoint() ?? .zero
        let end = pathFraction.getEndPoint() ?? .zero


        return Path { path in
            pathFraction.forEach { element in
                switch element.self {
                case .move(let to):
                    path.move(to: to)
                case .line(let to):
                    path.addLine(to: reflect(start, end, to))
                case .quadCurve(let to, let control):
                    path.addQuadCurve(to: reflect(start, end, to),
                                      control: reflect(start, end, control))
                case .curve(let to, let control1, let control2):
                    path.addCurve(to: reflect(start, end, to),
                                  control1: reflect(start, end, control1),
                                  control2: reflect(start, end, control2))
                case .closeSubpath:
                    path.closeSubpath()
                }
            }
        }
    }

    public var body: some View {
        GeometryReader { (proxy: GeometryProxy) in
            ZStack {
                self.shape.path(in: proxy.frame(in: .global))
                    .trimmedPath(from: 0, to:  self.fraction)
                    .foregroundColor(self.mainColor)
                    .opacity(0.4)
                self.makeFold(path: self.shape.path(in: proxy.frame(in: .global)))
                    .foregroundColor(self.foldColor)
                    .opacity(0.4)
            }
        }
    }
}

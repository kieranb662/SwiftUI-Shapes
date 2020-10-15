import SwiftUI

// https://swiftui-lab.com/swiftui-animations-part2/
public struct InfinitySymbol: Shape {
    public init() {}
    var insetAmount: CGFloat = 0
    public func path(in rect: CGRect) -> Path {
        createInfinityPath(in: rect)
            .offsetBy(dx: insetAmount, dy: insetAmount)
    }

    public func createInfinityPath(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let height = rect.height
        let width = rect.width
        let heightFactor = height/4
        let widthFactor = width/4

        var path = Path()

        path.move(to: CGPoint(x:widthFactor, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor),
                      control1: CGPoint(x:0, y: heightFactor * 3),
                      control2: CGPoint(x:0, y: heightFactor))

        path.move(to: CGPoint(x:widthFactor, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3),
                      control1: CGPoint(x:widthFactor * 2, y: heightFactor),
                      control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))

        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor),
                      control1: CGPoint(x:widthFactor * 4 + 5, y: heightFactor * 3),
                      control2: CGPoint(x:widthFactor * 4 + 5, y: heightFactor))

        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor * 3),
                      control1: CGPoint(x:widthFactor * 2, y: heightFactor),
                      control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))

        return path
    }
}

extension InfinitySymbol: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}


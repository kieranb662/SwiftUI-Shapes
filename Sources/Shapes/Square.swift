import SwiftUI

public struct Square: Shape {
    var insetAmount: CGFloat = 0
    /// Creates the largest square that will fit in the containing `CGRect`
    public init() {}

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let rect = rect.insetBy(dx: insetAmount, dy: insetAmount)
            let isWidthSmaller = rect.width < rect.height
            let length = min(rect.width, rect.height)
            let x = isWidthSmaller ? 0 : (rect.width - length)/2
            let y = isWidthSmaller ? (rect.height - length)/2 : 0

            path.addRect(
                CGRect(x: x, y: y, width: length, height: length)
                    .offsetBy(dx: rect.minX, dy: rect.minY)
            )
        }
    }
}

extension Square: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

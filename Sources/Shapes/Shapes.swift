import SwiftUI

/// A type erased `Shape`
public struct AnyShape: Shape {
    private let _makePath: (CGRect) -> Path

    public init<S: Shape>(_ shape: S) {
        self._makePath = shape.path
    }

    public func path(in rect: CGRect) -> Path {
        self._makePath(rect)
    }
}

public extension Shape {
    func eraseToAnyShape() -> AnyShape {
        AnyShape(self)
    }
}

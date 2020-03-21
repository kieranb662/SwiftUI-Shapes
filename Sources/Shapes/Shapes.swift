import SwiftUI


@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct AnyShape: Shape {
    private let _makePath: (CGRect) -> Path
    
    @available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
    public init<S: Shape>(_ shape: S) {
        self._makePath = shape.path
    }

    public func path(in rect: CGRect) -> Path {
        self._makePath(rect)
    }
}
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
extension Shape {
    public func eraseToAnyShape() -> AnyShape {
        AnyShape(self)
    }
}

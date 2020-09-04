import SwiftUI


public struct Square: Shape {
    public init() {}
    public func path(in rect: CGRect) -> Path {

        Path { path in

            let length = min(rect.width, rect.height)

            let x = (
                rect.width < rect.height
                    ? 0
                    : (rect.width - length)/2
                ) + rect.minX

            let y = (
                rect.width < rect.height
                    ? (rect.height - length)/2
                    : 0
                ) + rect.minY

            path.addRect(
                CGRect(
                    x: x ,
                    y: y ,
                    width: length,
                    height: length
                )
            )
        }
    }
}

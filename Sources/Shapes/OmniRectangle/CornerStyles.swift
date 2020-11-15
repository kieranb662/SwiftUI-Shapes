// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

extension OmniRectangle {
    public struct CornerStyles {
        public var topLeft: CornerStyle
        public var topRight: CornerStyle
        public var bottomLeft: CornerStyle
        public var bottomRight: CornerStyle
        
        public init(topLeft: CornerStyle, topRight: CornerStyle, bottomLeft: CornerStyle, bottomRight: CornerStyle) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }
        
        public init(_ corners: UIRectCorner = .allCorners, style: CornerStyle) {
            self.topLeft     = corners.contains(.topLeft)     ? style : .square
            self.bottomLeft  = corners.contains(.bottomLeft)  ? style : .square
            self.topRight    = corners.contains(.topRight)    ? style : .square
            self.bottomRight = corners.contains(.bottomRight) ? style : .square
        }
        
        public static func allSquare() -> CornerStyles {
            CornerStyles(topLeft: .square,
                         topRight: .square,
                         bottomLeft: .square,
                         bottomRight: .square)
        }
    }
}


extension OmniRectangle.CornerStyles: CustomStringConvertible {
    public var description: String {
        """
        \(topLeft.description)
        \(topRight.description)
        \(bottomLeft.description)
        \(bottomRight)
        """
    }
}

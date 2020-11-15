// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/15/20.
//
// Author: Kieran Brown
//

import Foundation

extension OmniRectangle {
    public struct Corner : OptionSet {
        public var rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static var topLeft: Corner = Corner(rawValue: 1 << 0)
        public static var topRight: Corner = Corner(rawValue: 1 << 1)
        public static var bottomLeft: Corner = Corner(rawValue: 1 << 2)
        public static var bottomRight: Corner = Corner(rawValue: 1 << 3)

        public static var allCorners: Corner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }
}

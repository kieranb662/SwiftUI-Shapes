// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/15/20.
//
// Author: Kieran Brown
//

import Foundation

extension OmniRectangle {
    public struct Edge : OptionSet {
        public var rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static var top: Edge = Edge(rawValue: 1 << 0)
        public static var left: Edge = Edge(rawValue: 1 << 1)
        public static var bottom: Edge = Edge(rawValue: 1 << 2)
        public static var right: Edge = Edge(rawValue: 1 << 3)

        public static var all: Edge = [.left, .right, .top, .bottom]
    }
}

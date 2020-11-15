// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/14/20.
//
// Author: Kieran Brown
//

import SwiftUI

extension OmniRectangle {
    public struct EdgeStyles {
        public var leftCurvature: CGFloat
        public var topCurvature: CGFloat
        public var rightCurvature: CGFloat
        public var bottomCurvature: CGFloat
        
        public init(leftCurvature: CGFloat, topCurvature: CGFloat, rightCurvature: CGFloat, bottomCurvature: CGFloat) {
            self.leftCurvature = leftCurvature
            self.topCurvature = topCurvature
            self.rightCurvature = rightCurvature
            self.bottomCurvature = bottomCurvature
        }
        
        public init(_ edges: UIRectEdge = .all, curvature: CGFloat) {
            self.leftCurvature   = edges.contains(.left)   ? curvature : 0
            self.topCurvature    = edges.contains(.top)    ? curvature : 0
            self.rightCurvature  = edges.contains(.right)  ? curvature : 0
            self.bottomCurvature = edges.contains(.bottom) ? curvature : 0
        }
        
        public static func allFlat() -> EdgeStyles {
            EdgeStyles(leftCurvature: 0,
                       topCurvature: 0,
                       rightCurvature: 0,
                       bottomCurvature: 0)
        }
    }
}

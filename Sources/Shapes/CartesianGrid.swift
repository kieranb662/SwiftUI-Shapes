//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import SwiftUI

public struct CartesianGrid: Shape {
    public var xCount: Int
    public var yCount: Int

    public init(xCount: Int, yCount: Int) {
        self.xCount = xCount
        self.yCount = yCount
    }

    public func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let rangeX = 1...xCount
        let rangeY = 1...yCount

        return Path { path in
            for i in rangeX {
                path.move(to: CGPoint(x: CGFloat(i)*w/CGFloat(self.xCount), y: 0))
                path.addLine(to: CGPoint(x: CGFloat(i)*w/CGFloat(self.xCount), y: h))
            }
            for j in rangeY {
                path.move(to: CGPoint(x: 0, y: CGFloat(j)*h/CGFloat(self.yCount)))
                path.addLine(to: CGPoint(x: w, y: CGFloat(j)*h/CGFloat(self.yCount)))
            }
        }
    }
}

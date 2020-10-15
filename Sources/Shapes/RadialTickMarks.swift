//  Created by Kieran Brown on 4/8/20.
//  Copyright © 2020 BrownandSons. All rights reserved.


import SwiftUI

public struct RadialTickMarks: Shape {
    func determineScale(_ i: Int) -> CGFloat {
        switch i%6 {
        case 1,2,4,5: return 1.05
        case 0:       return 1.15
        case 3:       return 1.1
        default:      return 0
        }
    }

    public init() {}

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let r = min(rect.width, rect.height)/2
            let mid = CGPoint(x: rect.midX, y: rect.midY)
            let values = 0..<24
            for i in values {
                let angle = .pi*2*CGFloat(i)/24
                let x = cos(angle)
                let y = sin(angle)
                path.move(to: CGPoint(x: 0.95*r*x, y: 0.95*r*y) + mid)
                path.addLine(to: CGPoint(x: self.determineScale(i)*r*x, y: self.determineScale(i)*r*y) + mid)
            }
        }
    }

}

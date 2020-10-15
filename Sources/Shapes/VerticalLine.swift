//
//  VerticalLine.swift
//  
//
//  Created by Kieran Brown on 10/15/20.
//

import SwiftUI

public struct VerticalLine: Shape {
    var offset: CGFloat

    /// A Vertical line that is the height of its container
    /// -   parameter offset: A value between 0 and 1 defining the line's horizontal offset in its container (**Default**: 0.5)
    public init(offset: CGFloat = 0.5) {
        self.offset = offset
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX*offset, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX*offset, y: rect.height))
        }
    }
}

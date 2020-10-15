//  Created by Kieran Brown on 3/21/20.
//  Copyright © 2020 BrownandSons. All rights reserved.

import SwiftUI

public struct Arrow: Shape {
    public var arrowOffset: CGFloat
    public var length: CGFloat

    /// An arrow that when small is shaped like this **|--|** but when gets longer looks like this **<---->**
    /// - parameters:
    ///  - arrowOffset: The percent `[0,1]` horizontal offset of the arrow in its container
    ///  - length: The length of the arrow
    ///
    /// ## Example usage
    /// ```
    ///   struct ExpandingArrowExample: View {
    ///       @State var val: Double = 10
    ///       @State var isHidden: Bool = false
    ///
    ///       var body: some View {
    ///           VStack {
    ///               HStack(spacing: 0) {
    ///                   ForEach(1..<9) { (i)  in
    ///                       Arrow(arrowOffset: self.val > 100 ? 1/(2*1.414) : 0, length: CGFloat(self.val))
    ///                           .stroke(Color("Light Green")).animation(.easeIn(duration: Double(i)/4.0))
    ///                           .frame(width: 40)
    ///                   }
    ///               }
    ///               .frame(height: 300)
    ///               Slider(value: $val, in: 1...250).padding()
    ///           }
    ///       }
    ///    }
    /// ```
    public init(arrowOffset: CGFloat, length: CGFloat) {
        self.arrowOffset = arrowOffset
        self.length = length
    }

    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(arrowOffset, length) }
        set {
            arrowOffset = newValue.first
            length = newValue.second
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let w = rect.width
            let h = rect.height

            path.move(to: CGPoint(x: w/2, y: h/2 - self.length/2))
            path.addLine(to: CGPoint(x: w/2, y: h/2 + self.length/2))

            path.move(to: h > 40 ? CGPoint(x: w*self.arrowOffset, y: w*self.arrowOffset +  h/2 - self.length/2) : CGPoint(x: 0, y:  h/2 - self.length/2))
            path.addLine(to: CGPoint(x: w/2, y:  h/2 - self.length/2))
            path.addLine(to:  h > 40 ? CGPoint(x: w-w*self.arrowOffset, y: w*self.arrowOffset + h/2 - self.length/2) : CGPoint(x: w, y:  h/2 - self.length/2))

            path.move(to: h > 40 ? CGPoint(x: w*self.arrowOffset, y: h/2 + self.length/2 - w*self.arrowOffset) : CGPoint(x: 0, y: h/2 + self.length/2))
            path.addLine(to: CGPoint(x: w/2, y: h/2 + self.length/2))
            path.addLine(to:  h > 40 ? CGPoint(x: w-w*self.arrowOffset, y: h/2 + self.length/2 - w*self.arrowOffset) : CGPoint(x: w, y: h/2 + self.length/2))
        }
    }
}

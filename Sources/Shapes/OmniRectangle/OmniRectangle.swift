// Swift toolchain version 5.0
// Running macOS version 10.15
// Created on 11/13/20.
//
// Author: Kieran Brown
//


import SwiftUI

public struct OmniRectangle: Shape {
    private var insetAmount: CGFloat = 0
    private var cornerStyles: CornerStyles
    private var edgeStyles: EdgeStyles
    
    // TODO: Add in the animation data for the corner styles
    public var animatableData: AnimatablePair<AnimatablePair<CGFloat, CGFloat>,
                                              AnimatablePair<CGFloat, CGFloat>> {
        get {
            AnimatablePair(
                AnimatablePair(edgeStyles.leftCurvature, edgeStyles.topCurvature),
                AnimatablePair(edgeStyles.rightCurvature, edgeStyles.bottomCurvature)
            )
        }
        set {
            edgeStyles[keyPath: \.leftCurvature] = newValue.first.first
            edgeStyles[keyPath: \.topCurvature] = newValue.first.second
            edgeStyles[keyPath: \.rightCurvature] = newValue.second.first
            edgeStyles[keyPath: \.bottomCurvature] = newValue.second.second
        }
    }
    
    public init(corners: CornerStyles = .allSquare(), edges: EdgeStyles = .allFlat()) {
        self.cornerStyles = corners
        self.edgeStyles = edges
    }
    
    public init(topLeft: CornerStyle, topRight: CornerStyle, bottomLeft: CornerStyle, bottomRight: CornerStyle) {
        self.cornerStyles = CornerStyles(topLeft: topLeft,
                                         topRight: topRight,
                                         bottomLeft: bottomLeft,
                                         bottomRight: bottomRight)
        self.edgeStyles = .allFlat()
    }
    
    public init(leftEdgeCurvature: CGFloat, topEdgeCurvature: CGFloat, rightEdgeCurvature: CGFloat, bottomEdgeCurvature: CGFloat) {
        self.edgeStyles = EdgeStyles(leftCurvature: leftEdgeCurvature,
                                     topCurvature: topEdgeCurvature,
                                     rightCurvature: rightEdgeCurvature,
                                     bottomCurvature: bottomEdgeCurvature)
        self.cornerStyles = .allSquare()
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
            let (width, height) = (insetRect.width, insetRect.height)
            let control = CGPoint(x: width/2, y: edgeStyles.topCurvature*height/2)
            
            cornerStyles.topRight.applyTopRight(&path, width, height)
            cornerStyles.bottomRight.applyBottomRight(&path, width, height, edgeStyles.rightCurvature)
            cornerStyles.bottomLeft.applyBottomLeft(&path, width, height, edgeStyles.bottomCurvature)
            cornerStyles.topLeft.applyTopLeft(&path, width,height, edgeStyles.leftCurvature)
            
            let checkMin: (CGFloat) -> CGFloat = { min(min($0, height/2), width/2) }
            
            switch cornerStyles.topRight {
            case .round(let radius):
                path.addQuadCurve(to: CGPoint(x: width - checkMin(radius), y: 0), control: control)
            case .cut(let depth):
                path.addQuadCurve(to: CGPoint(x: width - checkMin(depth), y: 0), control: control)
            case .square:
                path.addQuadCurve(to: CGPoint(x: width, y: 0), control: control)
            }
            
            path.closeSubpath()
        }
        .offsetBy(dx: insetAmount, dy: insetAmount)
    }
}

extension OmniRectangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

//
//extension OmniRectangle {
//    fileprivate func prepare(stroke: StrokeStyle, width: CGFloat = 100, height: CGFloat = 100) -> some View {
//        ZStack {
//            self
//                .strokeBorder(Color.red, style: stroke)
//        }
//        .padding()
//        .frame(width: width, height: height)
//        //            .border(Color.red)
//    }
//}
//
//// MARK: - This preview is meant to be used on an iPad Pro 12.9in simulator
//
//struct OmniRectangle_Previews: PreviewProvider {
//    static let roundThinStrokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .round)
//    static let roundThickStrokeStyle = StrokeStyle(lineWidth: 30, lineJoin: .round)
//    static let miterThinStrokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .miter)
//    static let miterThickStrokeStyle = StrokeStyle(lineWidth: 30, lineJoin: .miter)
//    static let bevelThinStrokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .bevel)
//    static let bevelThickStrokeStyle = StrokeStyle(lineWidth: 30, lineJoin: .bevel)
//    
//    static let cornerMedley = OmniRectangle.CornerStyles(
//        topLeft: .round(radius: 0),
//        topRight: .round(radius: 10),
//        bottomLeft: .cut(depth: 15),
//        bottomRight: .cut(depth: 0)
//    )
//    
//    static let maxCutDepth = OmniRectangle.CornerStyles(style: .cut(depth: 100))
//    static let maxCornerRadius = OmniRectangle.CornerStyles(style: .round(radius: 100))
//    
//    static let squareCornersFlatEdges   = OmniRectangle()
//    static let roundCornersFlatEdges    = OmniRectangle(corners: OmniRectangle.CornerStyles(style: .round(radius: 10)))
//    static let maxRoundCornersFlatEdges = OmniRectangle(corners: maxCornerRadius)
//    static let cutCornersFlatEdges      = OmniRectangle(corners: OmniRectangle.CornerStyles(style: .cut(depth: 10)))
//    static let maxCutCornersFlatEdges   = OmniRectangle(corners: maxCutDepth)
//    static let cornerMedleyFlatEdges    = OmniRectangle(corners: cornerMedley)
//    
//    static let fullPositiveCurvature = OmniRectangle.EdgeStyles(curvature: 1)
//    static let halfPositiveCurvature = OmniRectangle.EdgeStyles(curvature: 0.5)
//    static let fullNegativeCurvature = OmniRectangle.EdgeStyles(curvature: -1)
//    static let halfNegativeCurvature = OmniRectangle.EdgeStyles(curvature: -0.5)
//    
//    static func makeRow(_ omniShape: OmniRectangle) -> some View {
//        HStack(spacing: 30) {
//            Text(omniShape.cornerStyles.description)
//                .frame(width: 100, height: 100, alignment: .leading)
//            
//            omniShape
//                .fill(Color.purple)
//                .padding()
//                .frame(width: 100, height: 100)
//            omniShape.prepare(stroke: roundThinStrokeStyle)
//            omniShape.prepare(stroke: roundThickStrokeStyle)
//            omniShape.prepare(stroke: miterThinStrokeStyle)
//            omniShape.prepare(stroke: miterThickStrokeStyle)
//            omniShape.prepare(stroke: bevelThinStrokeStyle)
//            omniShape.prepare(stroke: bevelThickStrokeStyle)
//        }
//    }
//    
//    static func makeCurvatureGroup(corners: OmniRectangle.CornerStyles) -> some View {
//        Group {
//            makeRow(OmniRectangle(corners: corners, edges: fullPositiveCurvature))
//            makeRow(OmniRectangle(corners: corners, edges: halfPositiveCurvature))
//            makeRow(OmniRectangle(corners: corners, edges: .allFlat()))
//            makeRow(OmniRectangle(corners: corners, edges: halfNegativeCurvature))
//            makeRow(OmniRectangle(corners: corners, edges: fullNegativeCurvature))
//        }
//    }
//    
//    static func makeLabel(lineWidth: CGFloat, lineJoin: String) -> some View {
//        Text("Stroked\nwidth: \(String(format: "%.0f", Double(lineWidth)))\njoin: \(lineJoin)")
//            .frame(width: 100, height: 100)
//    }
//    
//    static func header() -> some View {
//        HStack(alignment: .firstTextBaseline, spacing: 30) {
//            //            Text("Top left:\nTop right:\nBottom left:\nBottom right:\n")
//            Text("Filled")
//                .frame(width: 100, height: 100)
//            makeLabel(lineWidth: 1, lineJoin: "round")
//            makeLabel(lineWidth: 30, lineJoin: "round")
//            makeLabel(lineWidth: 1, lineJoin: "miter")
//            makeLabel(lineWidth: 30, lineJoin: "miter")
//            makeLabel(lineWidth: 1, lineJoin: "bevel")
//            makeLabel(lineWidth: 30, lineJoin: "bevel")
//        }
//    }
//    
//    static var previews: some View {
//        ScrollView {
//            LazyVStack(spacing: 40, pinnedViews: [.sectionHeaders]) {
//                Section(header: ZStack {
//                    Color(white: 0.05)
//                        .edgesIgnoringSafeArea(.top)
//                        .frame(height: 120)
//                    header()
//                }) {
//                    Group {
//                        makeRow(squareCornersFlatEdges)
//                        makeRow(roundCornersFlatEdges)
//                        makeRow(maxRoundCornersFlatEdges)
//                        makeRow(cutCornersFlatEdges)
//                        makeRow(maxCutCornersFlatEdges)
//                        makeRow(cornerMedleyFlatEdges)
//                    }
//                    makeCurvatureGroup(corners: .allSquare())
//                    makeCurvatureGroup(corners: cornerMedley)
//                    
//                }
//            }
//        }.preferredColorScheme(.dark).edgesIgnoringSafeArea(.top)
//    }
//}

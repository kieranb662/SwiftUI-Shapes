// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shapes",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(
            name: "Shapes",
            targets: ["Shapes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kieranb662/CGExtender.git", from: "1.0.1")
    ],
    targets: [
        .target(
            name: "Shapes",
            dependencies: ["CGExtender"]),
        .testTarget(
            name: "ShapesTests",
            dependencies: ["Shapes"]),
    ]
)

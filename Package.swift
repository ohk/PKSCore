// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PKSCore",
    platforms: [.macOS(.v13), .iOS(.v16), .tvOS(.v12), .watchOS(.v4), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PKSUICore",
            targets: ["PKSUICore"]),
        .library(
            name: "PKSFoundation",
            targets: ["PKSFoundation"])
    ],
    targets: [
        .target(
            name: "PKSUICore",
            dependencies: [
                "PKSFoundation"
            ],
            path: "PKSUICore/Sources"
        ),
        .target(
            name: "PKSFoundation",
            dependencies: [],
            path: "PKSFoundation/Sources"
        ),
        .testTarget(
            name: "PKSUICoreTests",
            dependencies: ["PKSUICore", "PKSFoundation"]),
        .testTarget(
            name: "PKSFoundationTests",
            dependencies: ["PKSFoundation"])
    ]
)

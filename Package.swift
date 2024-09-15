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
            targets: ["PKSUICore"]
        ),
        .library(
            name: "PKSFoundation",
            targets: ["PKSFoundation"]
        ),
        .library(name: "PKSNetwork", targets: ["PKSNetwork"])
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", from: "12.8.0")
    ],
    targets: [
        .target(
            name: "PKSUICore",
            dependencies: [
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke"),
                .target(name: "PKSFoundation")
            ],
            path: "PKSUICore/Sources"
        ),
        .target(
            name: "PKSFoundation",
            dependencies: [],
            path: "PKSFoundation/Sources"
        ),
        .target(
            name: "PKSNetwork",
            dependencies: [
                .target(name: "PKSFoundation")
            ],
            path: "PKSNetwork/Sources"
        ),
       
        .testTarget(
            name: "PKSUICoreTests",
            dependencies: ["PKSUICore", "PKSFoundation"]),
        .testTarget(
            name: "PKSFoundationTests",
            dependencies: ["PKSFoundation"])
    ]
)

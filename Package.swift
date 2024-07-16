// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftuiNative",
    platforms:  [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)] + [.visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftuiNative",
            targets: ["SwiftuiNative"]
        ),
        .library(
            name: "SwiftuiNativeTests",
            targets: ["SwiftuiNativeTests"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftuiNative",
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .target(
            name: "SwiftuiNativeTests",
            dependencies: ["SwiftuiNative"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .testTarget(
            name: "UnitTests",
            dependencies: ["SwiftuiNativeTests"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
    ]
)

import ProjectDescription

let dest: Set<Destination> = [.iPhone, .mac, .macCatalyst, .appleWatch, .appleTv, .appleVision]

let project = Project(
    name: "HostApp",
    targets: [
        .target(
            name: "HostApp",
            destinations: dest,
            product: .app,
            bundleId: "io.tuist.HostApp",
            infoPlist: .default,
            sources: ["App.swift"],
            resources: [],
            dependencies: [
                 .package(product: "SwiftuiNative"),
            ],
            additionalFiles: [
                .folderReference(path: "..")
            ]
        ),
        .target(
            name: "HostAppTests",
            destinations: dest,
            product: .unitTests,
            bundleId: "io.tuist.HostAppTests",
            infoPlist: .default,
            sources: ["Tests.swift"],
            resources: [],
            dependencies: [
                .target(name: "HostApp"),
                .package(product: "SwiftuiNativeTests")
            ]
        ),
    ]
)

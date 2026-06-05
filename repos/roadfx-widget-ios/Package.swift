// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ROADFXWidget",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "ROADFXWidget", targets: ["ROADFXWidget"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ROADFXWidget",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "ROADFXWidgetTests",
            dependencies: ["ROADFXWidget"]
        )
    ]
)

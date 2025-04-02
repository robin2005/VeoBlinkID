// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "VeoBlinkID",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "VeoBlinkID",
            targets: ["VeoBlinkID"]),
    ],
    dependencies: [
        // 基础依赖
    ],
    targets: [
        .target(
            name: "VeoBlinkID",
            dependencies: [
                .target(name: "VeoBlinkID")
            ]
        ),
        .target(
            name: "VeoBlinkID",
            dependencies: [
                 .binaryTarget(
                     name: "BlinkID",
                     url: "https://github.com/BlinkID/blinkid-ios/releases/download/v6.13.0/BlinkID.xcframework.zip",
                     condition: .when(platforms: [.iOS("15")])
                 ),
                .target(
                    name: "BlinkIDUX",
                    condition: .when(platforms: [.iOS("16")]),
                    products: [
                          .library(name: "BlinkIDUX", type: .dynamic, targets: ["BlinkIDUX"])
                    ],
                    targets: [.target(name: "BlinkIDUX",
                                        dependencies: ["BlinkID"],
                                        path: "Source",
                                        resources: [
                                            .process("PrivacyInfo.xcprivacy"),
                                            .process("BlinkIDUX/Localizable.xcstrings")],
                                        swiftSettings: [.enableUpcomingFeature("ExistentialAny")]),
                                 .binaryTarget(
                                    name: "BlinkID",
                                    path: "Frameworks/BlinkID.xcframework"
                                 )]
                )
            ]
        )
    ]
)

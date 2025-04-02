// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "YourPackage",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "YourLibrary",
            targets: ["YourTarget"]),
    ],
    dependencies: [
        // 基础依赖
    ],
    targets: [
        .target(
            name: "YourTarget",
            dependencies: [
                .target(name: "SDKWrapper")
            ]
        ),
        .target(
            name: "SDKWrapper",
            dependencies: [
                .target(
                    name: "SDKVersion1",
                    condition: .when(platforms: [.iOS("15.0")..<.iOS("16.0")])
                ),
                .target(
                    name: "SDKVersion2",
                    condition: .when(platforms: [.iOS("16.0")])
                )
            ]
        ),
        .target(
            name: "SDKVersion1",
            dependencies: [
                .binaryTarget(
                    name: "BlinkID",
                    url: "https://github.com/BlinkID/blinkid-ios/releases/download/v6.13.0/BlinkID.xcframework.zip"
                )
            ]
        ),
        .target(
            name: "SDKVersion2",
            dependencies: [
                .target(
                    name: "BlinkIDUX",
                    dependencies: ["BlinkID"],
                    path: "Source",
                    resources: [
                        .process("PrivacyInfo.xcprivacy"),
                        .process("BlinkIDUX/Localizable.xcstrings")
                    ],
                    swiftSettings: [.enableUpcomingFeature("ExistentialAny")]
                ),
                .binaryTarget(
                    name: "BlinkID",
                    path: "Frameworks/BlinkID.xcframework"
                )
            ]
        )
    ]
)

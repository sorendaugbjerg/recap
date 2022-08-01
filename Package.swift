// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "google-recaptcha-v2-ios",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "google-recaptcha-v2-ios",
            targets: ["google-recaptcha-v2-ios"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "google-recaptcha-v2-ios",
            dependencies: []),
        .testTarget(
            name: "google-recaptcha-v2-iosTests",
            dependencies: ["google-recaptcha-v2-ios"]),
    ]
)

// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PHSPopupView",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17)
    ],
    products: [
        .library(name: "PHSPopupView", targets: ["PHSPopupView"])
    ],
    targets: [
        .target(name: "PHSPopupView", dependencies: [], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)

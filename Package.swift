// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SlackKit",
    platforms: [
        .macOS(.v10_15), .iOS(.v10), .tvOS(.v10)
    ],
    products: [
        .library(name: "SlackKit", targets: ["SlackKit"]),
        .library(name: "SKClient", targets: ["SKClient"]),
        .library(name: "SKCore", targets: ["SKCore"]),
        .library(name: "SKWebAPI", targets: ["SKWebAPI"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SlackKit",
                dependencies: ["SKCore", "SKClient", "SKWebAPI"],
                path: "SlackKit/Sources"),
        .target(name: "SKClient",
                dependencies: ["SKCore"],
                path: "SKClient/Sources"),
        .target(name: "SKCore",
                path: "SKCore/Sources"),
        .target(name: "SKWebAPI",
                dependencies: ["SKCore"],
                path: "SKWebAPI/Sources"),
    ],
    swiftLanguageVersions: [.v5]
)

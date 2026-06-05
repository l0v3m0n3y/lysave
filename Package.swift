// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "lysave",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "lysave", targets: ["lysave"]),
    ],
    targets: [
        .target(
            name: "lysave",
            path: "src"
        ),
    ]
)

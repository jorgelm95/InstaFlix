// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InstaFlixData",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "InstaFlixData",
            targets: ["InstaFlixData"]),
    ],
    dependencies: [
        .package(path: "../../InstaFlix/InstaFlixNetworking"),
        .package(path: "../../InstaFlix/InstaFlixDomain"),
        .package(url: "https://github.com/realm/realm-swift", from: "10.54.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "InstaFlixData",
            dependencies: [
                .product(name: "InstaFlixNetworking", package: "InstaFlixNetworking"),
                .product(name: "InstaFlixDomain", package: "InstaFlixDomain"),
                .product(name: "RealmSwift", package: "realm-swift")
            ]),
        .testTarget(
            name: "InstaFlixDataTests",
            dependencies: ["InstaFlixData"]),
    ]
)

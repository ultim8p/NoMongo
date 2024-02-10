// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NoMongo",
    platforms: [
       .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NoMongo",
            targets: ["NoMongo"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/orlandos-nl/MongoKitten.git", from: "7.2.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NoMongo",
            dependencies: [
                .product(name: "MongoKitten", package: "MongoKitten"),
                .product(name: "Vapor", package: "vapor"),
            ]),
        .testTarget(
            name: "NoMongoTests",
            dependencies: ["NoMongo"]),
    ]
)

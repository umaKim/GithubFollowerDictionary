// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubFollowerDictionaryApp",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "PresentationLayer", targets: ["PresentationLayer"]),
        .library(name: "DomainLayer", targets: ["DomainLayer"]),
        .library(name: "DataLayer", targets: ["DataLayer"]),
        .library(name: "DependencyManager", targets: ["DependencyManager"])
    ],
    dependencies: [
        .package(url: "https://github.com/CombineCommunity/CombineCocoa.git", exact: .init("0.4.1")!)
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        
        .target(name: "DependencyManager", dependencies: ["PresentationLayer", "DomainLayer", "DataLayer"]),
        
        .target(name: "PresentationLayer", dependencies: ["DomainLayer", "CombineCocoa"]),
        .target(name: "DomainLayer", dependencies: []),
        .target(name: "DataLayer", dependencies: ["DomainLayer"]),
        
        .testTarget(
            name: "GitHubFollowerDictionaryAppTests",
            dependencies: []),
    ]
)

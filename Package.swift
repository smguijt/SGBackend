// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "SGBackend",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.99.3"),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
        // 🪶 Fluent driver for SQLite.
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.6.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        // SGBackend Server
        .package(url: "https://github.com/smguijt/SGShared.git", branch: "master"),
        // BinaryBirds DSL
        //.package(url: "https://github.com/binarybirds/liquid", from: "1.3.0"),
        //.package(url: "https://github.com/binarybirds/swift-html", from: "1.6.0"),
        //.package(url: "https://github.com/binarybirds/spec", from: "1.2.0"),
        .package(url: "https://github.com/vapor/leaf", from: "4.3.0"),
        .package(url: "https://github.com/vapor/leaf-kit.git", from: "1.10.3"), 
        .package(url: "https://github.com/brokenhandsio/leaf-error-middleware.git", from: "4.0.0")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "SGShared", package: "SGShared"),
                //.product(name: "Liquid", package: "liquid"),
                //.product(name: "SwiftHtml", package: "swift-html"),
                //.product(name: "SwiftSvg", package: "swift-html"),
                //.product(name: "SwiftRss", package: "swift-html"),
                //.product(name: "SwiftSitemap", package: "swift-html"),
                .product(name: "LeafKit", package: "leaf-kit"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "LeafErrorMiddleware", package: "leaf-error-middleware")
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
                .product(name: "SGShared", package: "SGShared"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableExperimentalFeature("StrictConcurrency"),
] }

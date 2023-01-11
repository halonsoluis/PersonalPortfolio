// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "SwiftPersonalPortfolio",
    products: [
        .executable(
            name: "SwiftPersonalPortfolio",
            targets: ["SwiftPersonalPortfolio"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "SwiftPersonalPortfolio",
            dependencies: ["Publish"]
        )
    ]
)

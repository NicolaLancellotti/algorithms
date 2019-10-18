// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "algorithms",
  products: [
    .library(
      name: "algorithms",
      targets: ["algorithms"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "algorithms",
      dependencies: []),
    .testTarget(
      name: "algorithmsTests",
      dependencies: ["algorithms"]),
  ]
)

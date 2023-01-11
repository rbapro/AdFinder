// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SearchScene",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "SearchScene",
      targets: ["SearchScene"]),
  ],
  dependencies: [
    .package(path: "../Entities")
  ],
  targets: [
    .target(
      name: "SearchScene",
      dependencies: [
        "Entities"
      ]),
    .testTarget(
      name: "SearchSceneTests",
      dependencies: ["SearchScene"]),
  ]
)

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
    .package(path: "../Entities"),
    .package(path: "../WebProxy"),
    .package(path: "../DesignSystem")
  ],
  targets: [
    .target(
      name: "SearchScene",
      dependencies: [
        "Entities",
        "WebProxy",
        "DesignSystem"
      ]),
    .testTarget(
      name: "SearchSceneTests",
      dependencies: ["SearchScene"]),
  ]
)

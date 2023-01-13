//
// AdsListRouter.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit

struct AdsListRouterDependencies {
  let viewController: UIViewController
}


final class AdsListRouter {
  private weak var viewController: UIViewController?

  init(dependencies: AdsListRouterDependencies) {
    viewController = dependencies.viewController
  }
}

// MARK: - AdsListRouting

extension AdsListRouter: AdsListRouting {
  @MainActor
  func routeToDetails() async {
    viewController?.splitViewController?.show(.secondary)
  }
}

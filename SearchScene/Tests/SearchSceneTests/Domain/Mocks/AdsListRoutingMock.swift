//
// AdsListRoutingMock.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
@testable import SearchScene

final class AdsListRoutingMock: AdsListRouting {

  var invokedRouteToDetails = false
  var invokedRouteToDetailsCount = 0

  func routeToDetails() {
    invokedRouteToDetails = true
    invokedRouteToDetailsCount += 1
  }
}

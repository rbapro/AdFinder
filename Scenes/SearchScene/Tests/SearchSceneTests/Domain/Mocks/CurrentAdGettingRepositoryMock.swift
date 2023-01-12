//
// CurrentAdGettingRepositoryMock.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
@testable import SearchScene

final class CurrentAdGettingRepositoryMock: CurrentAdGettingRepository {
  var invokedGet = false
  var invokedGetCount = 0

  var getAdReturnValue: CurrentAdRepositoryItem!
  var getAdClosure: (() -> CurrentAdRepositoryItem)?

  func get() async -> CurrentAdRepositoryItem? {
    invokedGet = true
    invokedGetCount += 1
    return getAdClosure.map({ $0() }) ?? getAdReturnValue
  }
}

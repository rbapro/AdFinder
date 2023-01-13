//
// CurrentAdSavingRepositoryMock.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
@testable import SearchScene

final class CurrentAdSavingRepositoryMock: CurrentAdSavingRepository {

  var invokedSave = false
  var invokedSaveCount = 0
  var invokedSaveParameters: (ad: CurrentAdRepositoryItem, Void)?

  var saveAdClosure: ((CurrentAdRepositoryItem) -> Void)?

  func save(ad: CurrentAdRepositoryItem) async {
    invokedSave = true
    invokedSaveCount += 1
    invokedSaveParameters = (ad, ())

    saveAdClosure.map({ $0(ad) })
  }
}

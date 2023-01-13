//
// AdsListInteractorOutputMock.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities
@testable import SearchScene

final class AdsListInteractorOutputMock: AdsListInteractorOutput {
  
  var invokedNotifyLoading = false
  var invokedNotifyLoadingCount = 0

  func notifyLoading() {
    invokedNotifyLoading = true
    invokedNotifyLoadingCount += 1
  }

  var invokedNotify = false
  var invokedNotifyCount = 0
  var invokedNotifyParameters: (category: AdsListInteractorCategory, Void)?

  func notify(category: AdsListInteractorCategory) {
    invokedNotify = true
    invokedNotifyCount += 1
    invokedNotifyParameters = (category, ())
  }
}

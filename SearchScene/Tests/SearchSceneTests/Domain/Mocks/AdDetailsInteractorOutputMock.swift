//
// AdDetailsInteractorOutputMock.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
@testable import SearchScene

final class AdDetailsInteractorOutputMock: AdDetailsInteractorOutput {

  var invokedNotifyLoading = false
  var invokedNotifyLoadingCount = 0

  func notifyLoading() {
    invokedNotifyLoading = true
    invokedNotifyLoadingCount += 1
  }

  var invokedNotifyCategory = false
  var invokedNotifyCategoryCount = 0
  var invokedNotifyCategoryParameter: AdDetailsInteractorCategory?

  func notify(category: AdDetailsInteractorCategory) async {
    invokedNotifyCategory = true
    invokedNotifyCategoryCount += 1
    invokedNotifyCategoryParameter = category
  }
}

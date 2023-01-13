//
// AdsRepositoryMock.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities
@testable import SearchScene

final class AdsRepositoryMock: AdsRepository {

  var invokedRetrieve = false
  var invokedRetrieveCount = 0

  var retrieveThrowableError: Error?
  var retrieveReturnValue: [AdEntity]?

  func retrieve() throws -> [AdEntity] {
    invokedRetrieve = true
    invokedRetrieveCount += 1

    if let error = retrieveThrowableError {
      throw error
    }

    return retrieveReturnValue ?? []
  }
}

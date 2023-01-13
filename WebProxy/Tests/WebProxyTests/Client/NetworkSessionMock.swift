//
// NetworkSessionMock.swift
// 
//
// Created by ronael.bajazet on 08/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
@testable import WebProxy

final class NetworkSessionMock: NetworkSession {
  required init(configuration: NetworkConfiguration) {}

  var invokedExecute = false
  var invokedExecuteCount = 0
  var invokedExecuteParameters: Request?

  var executeRequestThrowableError: Error?
  var executeRequestReturnValue: Data!
  var executeRequestClosure: ((Request) throws -> Data)?

  func execute(request: some Request) throws -> Data {
    invokedExecute = true
    invokedExecuteCount += 1
    invokedExecuteParameters = request

    if let error = executeRequestThrowableError {
      throw error
    }

    return try executeRequestClosure.map({ try $0(request) }) ?? executeRequestReturnValue
  }
}

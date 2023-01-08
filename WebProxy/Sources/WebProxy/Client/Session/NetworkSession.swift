//
// NetworkSession.swift
// 
//
// Created by ronael.bajazet on 07/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

struct NetworkConfiguration {
  let baseUrl: String

  public init(baseUrl: String) {
    self.baseUrl = baseUrl
  }
}

protocol NetworkSession {
  init(configuration: NetworkConfiguration)
  func execute(request: some Request) async throws -> Data
}

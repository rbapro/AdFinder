//
// NetworkClient.swift
// 
//
// Created by ronael.bajazet on 07/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol Network {
  func fetch<Model: Decodable>(request: some Request) async throws -> Model
}

class NetworkClient {

  // MARK: - Properties

  private let session: NetworkSession

  // MARK: - Init

  public init(session: NetworkSession) {
    self.session = session
  }
}

// MARK: - Network

extension NetworkClient: Network {
  public func fetch<Model: Decodable>(request: some Request) async throws -> Model {
    let data = try await session.execute(request: request)
    return try JSONDecoder().decode(Model.self, from: data)
  }
}

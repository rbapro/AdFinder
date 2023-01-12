//
// GetAdCategoriesService.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public protocol GetAdCategoriesServiceProtocol {
  func fetch() async throws -> [CategoryModel]
}

final class GetAdCategoriesService {

  private let client: Network

  init(client: Network) {
    self.client = client
  }
}

// MARK: - GetAdCategoriesServiceProtocol

extension GetAdCategoriesService: GetAdCategoriesServiceProtocol {
  func fetch() async throws -> [CategoryModel] {
    return try await client.fetch(request: GetAdCategoriesRequest())
  }
}

// MARK: - Request

private struct GetAdCategoriesRequest: Request {
  var path: String {
    WebProxyWrapper.shared.environment?.adCategoriesURLPath ?? ""
  }

  var method: String {
    "GET"
  }

  var parameters: Parameters = [:]
}

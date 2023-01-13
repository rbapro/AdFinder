//
// GetAdsService.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public protocol GetAdsServiceProtocol {
  func fetch() async throws -> [AdModel]
}

final class GetAdsService {

  private let client: Network

  init(client: Network) {
    self.client = client
  }
}

// MARK: - GetAdsServiceProtocol

extension GetAdsService: GetAdsServiceProtocol {
  func fetch() async throws -> [AdModel] {
    return try await client.fetch(request: GetAdsRequest())
  }
}

// MARK: - Request

private struct GetAdsRequest: Request {
  var path: String {
    WebProxyWrapper.shared.environment?.adsURLPath ?? ""
  }

  var method: String {
    "GET"
  }

  var parameters: Parameters = [:]
}

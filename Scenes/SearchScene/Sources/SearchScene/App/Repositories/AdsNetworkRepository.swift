//
// AdsNetworkRepository.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities
import WebProxy

final class AdsNetworkRepository {

  // MARK: - Properties

  private let service: GetAdsServiceProtocol

  // MARK: - Init

  init(service: GetAdsServiceProtocol) {
    self.service = service
  }
}

// MARK: - AdsRepository

extension AdsNetworkRepository: AdsRepository {
  func retrieve() async throws -> [Entities.AdEntity] {
    // TODO: -
    return []
  }

  func cancel() {
    // TODO: -
  }
}

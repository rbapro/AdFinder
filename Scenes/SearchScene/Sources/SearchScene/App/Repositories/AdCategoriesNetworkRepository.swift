//
// AdCategoriesNetworkRepository.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities
import WebProxy

final class AdCategoriesNetworkRepository {

  // MARK: - Properties

  private let service: GetAdCategoriesServiceProtocol

  // MARK: - Init

  init(service: GetAdCategoriesServiceProtocol) {
    self.service = service
  }
}

// MARK: - AdCategoriesRepository

extension AdCategoriesNetworkRepository: AdCategoriesRepository {
  func retrieve() async throws -> AdCategories {
    // TODO: -
    return [:]
  }

  func cancel() {
    // TODO: -
  }
}

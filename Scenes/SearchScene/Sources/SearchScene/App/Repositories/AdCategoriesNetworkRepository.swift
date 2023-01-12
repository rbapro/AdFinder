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
  private var task: Task<AdCategories, Error>?

  // MARK: - Init

  init(service: GetAdCategoriesServiceProtocol) {
    self.service = service
  }
}

// MARK: - AdCategoriesRepository

extension AdCategoriesNetworkRepository: AdCategoriesRepository {
  func retrieve() async throws -> AdCategories {
    let task = Task {
      let categories = try await service.fetch()
      return categories.reduce(into: AdCategories()) { $0[$1.id] = $1.name }
    }

    self.task = task
    return try await task.value
  }

  func cancel() {
    task?.cancel()
  }
}

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
  private var task: Task<[Ad], Error>?

  // MARK: - Init

  init(service: GetAdsServiceProtocol) {
    self.service = service
  }
}

// MARK: - AdsRepository

extension AdsNetworkRepository: AdsRepository {
  func retrieve() async throws -> [AdEntity] {
    let task = Task {
      let ads = try await service.fetch()
      return ads.compactMap {
        Ad(dependencies: AdDependencies(id: $0.id,
                                        categoryId: $0.categoryId,
                                        title: $0.title,
                                        description: $0.description,
                                        price: $0.price,
                                        images: [.init(small: $0.imagesUrl.small,
                                                       thumb: $0.imagesUrl.thumb)],
                                        creationDate: $0.date,
                                        isUrgent: $0.isUrgent,
                                        siret: $0.siret))
      }
    }

    self.task = task
    return try await task.value
  }

  func cancel() {
    task?.cancel()
  }
}

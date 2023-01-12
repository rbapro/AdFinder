//
// CurrentAdRepository.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol CurrentAdGettingRepository {
  func get() async -> CurrentAdRepositoryItem?
}

protocol CurrentAdSavingRepository {
  func save(ad: CurrentAdRepositoryItem) async
}

struct CurrentAdRepositoryItem {
  let id: Int
  let title: String
  let description: String
  let price: Double
  let images: [(small: URL?, thumb: URL?)]
  let creationDate: Date
  let isUrgent: Bool
  let siret: String?
  let category: String
}

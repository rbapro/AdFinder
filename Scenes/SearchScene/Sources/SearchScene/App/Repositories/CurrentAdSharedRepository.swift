//
// CurrentAdSharedRepository.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

final class CurrentAdSharedRepository {

  // MARK: - Singleton

  static let shared = CurrentAdSharedRepository()
  private init() {}

  // MARK: - Properties

  var currentAd: CurrentAdRepositoryItem?
}

// MARK: - CurrentAdSavingRepository

extension CurrentAdSharedRepository: CurrentAdSavingRepository {
  func save(ad: CurrentAdRepositoryItem) async {
    currentAd = ad
  }
}

// MARK: - CurrentAdGettingRepository

extension CurrentAdSharedRepository: CurrentAdGettingRepository {
  func get() async -> CurrentAdRepositoryItem? {
    currentAd
  }
}

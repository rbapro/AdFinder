//
// AdsListInteractorOutput.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol AdsListInteractorOutput: AnyObject {
  func notifyLoading() async
  func notify(category: AdsListInteractorCategory) async
}

enum AdsListInteractorCategory {
  case ads([Ad])
  case error
}

// MARK: - Ad

extension AdsListInteractorCategory: Equatable {
  struct Ad: Equatable {
    struct Image: Equatable {
      let small: URL?
      let thumb: URL?
    }

    let id: Int
    let title: String
    let image: [Image]
    let price: Double
    let isUrgent: Bool
    let category: String
  }
}

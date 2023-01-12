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

    struct Price: Equatable {
      let amount: Double
      let currencyCode: String
    }

    let id: Int
    let title: String
    let image: [Image]
    let price: Price
    let isUrgent: Bool
    let category: String
  }
}

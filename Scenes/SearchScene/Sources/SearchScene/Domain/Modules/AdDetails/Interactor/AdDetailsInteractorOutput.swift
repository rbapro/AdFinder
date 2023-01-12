//
// AdDetailsInteractorOutput.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol AdDetailsInteractorOutput: AnyObject {
  func notifyLoading() async
  func notify(category: AdDetailsInteractorCategory) async
}

enum AdDetailsInteractorCategory: Equatable {
  case details(Ad)
  case empty
}

// MARK: - Ad

extension AdDetailsInteractorCategory {
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
    let description: String
    let images: [Image]
    let price: Price
    let creationDate: Date
    let isUrgent: Bool
    let category: String
    let siret: String?
  }
}

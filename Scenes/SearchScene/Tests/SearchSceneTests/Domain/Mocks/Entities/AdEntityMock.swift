//
// AdEntityMock.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities

struct AdEntityMock: AdEntity {
  let id: Int
  let categoryId: Int
  let title: String
  let description: String
  let price: Double
  var images: [Entities.Ad.Image]
  let creationDate: Date
  let isUrgent: Bool
  let siret: String?
}

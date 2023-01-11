//
// AdModel.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public struct AdModel: Decodable {
  let id: Int
  let categoryId: Int
  let title: String
  let description: String
  let price: Double
  let imagesUrl: ImagesURL
  let creationDate: String
  let isUrgent: Bool?
}

public extension AdModel {
  struct ImagesURL: Decodable {
    let small: String?
    let thumb: String?
  }
}

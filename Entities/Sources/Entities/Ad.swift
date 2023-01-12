//
// Ad.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public protocol AdEntity {
  var id: Int { get }
  var title: String { get }
  var description: String { get }
  var price: Double { get }
  var images: [Ad.Image] { get }
  var creationDate: Date { get }
  var isUrgent: Bool { get }
  var siret: String? { get }
  var categoryId: Int { get }
}

public struct AdDependencies {
  let id: Int?
  let categoryId: Int?
  let title: String?
  let description: String?
  let price: Double?
  let images: [Ad.Image]?
  let creationDate: Date?
  let isUrgent: Bool?
  let siret: String?

  public init(id: Int?,
       categoryId: Int?,
       title: String?,
       description: String?,
       price: Double?,
       images: [Ad.Image]?,
       creationDate: Date?,
       isUrgent: Bool?,
       siret: String?) {
    self.id = id
    self.categoryId = categoryId
    self.title = title
    self.description = description
    self.price = price
    self.images = images
    self.creationDate = creationDate
    self.isUrgent = isUrgent
    self.siret = siret
  }
}

public struct Ad: AdEntity {

  // MARK: - Properties

  public let id: Int
  public let title: String
  public let description: String
  public let price: Double
  public let images: [Ad.Image]
  public let creationDate: Date
  public let isUrgent: Bool
  public let siret: String?
  public let categoryId: Int

  // MARK: - Init

  public init?(dependencies: AdDependencies) {
    guard let id = dependencies.id,
          let title = dependencies.title,
          let description = dependencies.description,
          let price = dependencies.price,
          let creationDate = dependencies.creationDate,
          let isUrgent = dependencies.isUrgent,
          let categoryId = dependencies.categoryId else { return nil }


    self.id = id
    self.title = title
    self.description = description
    self.price = price
    self.creationDate = creationDate
    self.isUrgent = isUrgent
    self.siret = dependencies.siret
    self.categoryId = categoryId

    images = dependencies.images?.compactMap {
      guard $0.small != nil || $0.thumb != nil else { return nil }
      return Image(small: $0.small, thumb: $0.thumb)
    } ?? []
  }
}

// MARK: - Image

public extension Ad {
  struct Image {
    public let small: URL?
    public let thumb: URL?

    public init(small: URL?, thumb: URL?) {
      self.small = small
      self.thumb = thumb
    }
  }
}

//
// AdModel.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public struct AdModel: Decodable {
  public let id: Int
  public let categoryId: Int
  public let title: String
  public let description: String
  public let price: Double
  public let imagesUrl: ImagesURL
  public let date: Date
  public let isUrgent: Bool
  public let siret: String?

  enum CodingKeys: String, CodingKey {
    case id
    case categoryId = "category_id"
    case title
    case description
    case price
    case imagesUrl = "images_url"
    case creationDate = "creation_date"
    case isUrgent = "is_urgent"
    case siret
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    categoryId = try container.decode(Int.self, forKey: .categoryId)
    title = try container.decode(String.self, forKey: .title)
    description = try container.decode(String.self, forKey: .description)
    price = try container.decode(Double.self, forKey: .price)
    imagesUrl = try container.decode(ImagesURL.self, forKey: .imagesUrl)

    let dateString = try container.decode(String.self, forKey: .creationDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let date = dateFormatter.date(from: dateString) else {
      throw DecodingError.dataCorruptedError(forKey: .creationDate,
                                             in: container,
                                             debugDescription: "Invalid date format")
    }
    self.date = date

    isUrgent = try container.decode(Bool.self, forKey: .isUrgent)
    siret = try container.decodeIfPresent(String.self, forKey: .siret)
  }
}

public extension AdModel {
  struct ImagesURL: Decodable {
    public let small: URL?
    public let thumb: URL?

    enum CodingKeys: CodingKey {
      case small
      case thumb
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let smallString = try container.decodeIfPresent(String.self, forKey: .small)
      small = URL(string: smallString ?? "")
      let thumbString = try container.decodeIfPresent(String.self, forKey: .thumb)
      thumb = URL(string: thumbString ?? "")
    }
  }
}

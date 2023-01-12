//
// AdCategoryEntity.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public typealias AdCategories = [Int: String]

public protocol AdCategoryEntity {
  var id: Int { get }
  var name: String { get }
}

public struct AdCategory: AdCategoryEntity {
  public let id: Int
  public let name: String
}

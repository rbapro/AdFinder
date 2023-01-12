//
// EnvironmentProvider.swift
// 
//
// Created by ronael.bajazet on 08/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public protocol EnvironmentProvider {
  var baseUrl: String { get }

  // MARK: - WS paths

  var adsURLPath: String { get }
  var adCategoriesURLPath: String { get }
}

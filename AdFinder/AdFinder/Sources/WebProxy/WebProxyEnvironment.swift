//
// WebProxyEnvironment.swift
// AdFinder
//
// Created by ronael.bajazet on 08/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import WebProxy

struct WebProxyEnvironment: EnvironmentProvider {
  var baseUrl: String {
    return ""
  }

  var adsURLPath: String {
    ""
  }

  var adCategoriesURLPath: String {
    ""
  }
}

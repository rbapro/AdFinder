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
    return "https://raw.githubusercontent.com/leboncoin/paperclip/master"
  }

  var adsURLPath: String {
    "/listing.json"
  }

  var adCategoriesURLPath: String {
    "/categories.json"
  }
}

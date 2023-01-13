//
// AdDetailsPresenterOutput.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol AdDetailsPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
  func displayAd(with item: AdDetailsViewItem)
  func displayEmptyState()
}

struct AdDetailsViewItem {
  let image: URL?
  let title: String
  let price: String?
  let creationDate: String?
  let category: String
  let descriptionTitle: String
  let description: String
  let urgentText: String?
  let siret: String?
}

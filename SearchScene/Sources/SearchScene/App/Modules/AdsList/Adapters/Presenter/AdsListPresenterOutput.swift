//
// AdsListPresenterOutput.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol AdsListPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
  func notiftList(with items: [AdsListViewItem])
  func notifyError()
}

struct AdsListViewItem: Hashable {
  let id: Int
  let image: URL?
  let category: String
  let title: String
  let price: String?
  let urgentText: String?
}

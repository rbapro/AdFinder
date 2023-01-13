//
// PriceFormatter.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol PriceFormatterProtocol {
  func format(price: Double, with currencyCode: String) -> String?
}

// MARK: - PriceFormatterProtocol

struct PriceFormatter: PriceFormatterProtocol {
  func format(price: Double, with currencyCode: String) -> String? {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currency
    formatter.currencyCode = currencyCode
    return formatter.string(for: price)
  }
}

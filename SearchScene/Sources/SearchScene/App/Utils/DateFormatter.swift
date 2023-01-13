//
// DateFormatter.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol DateFormatterProtocol {
  func string(from date: Date, withFormat template: String) -> String?
}

struct AFDateFormatter: DateFormatterProtocol {
  func string(from date: Date, withFormat template: String) -> String? {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate(template)
    return formatter.string(from: date)
  }
}

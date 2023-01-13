//
// Date.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

extension Date {
  init?(day: Int, month: Int, year: Int) {
    var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    calendar.timeZone = .current

    guard let date = DateComponents(calendar: calendar, year: year, month: month, day: day).date else {
      return nil
    }
    self = date
  }
}

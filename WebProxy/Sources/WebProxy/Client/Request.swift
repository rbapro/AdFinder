//
// Request.swift
// 
//
// Created by ronael.bajazet on 07/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol Request {
  var path: String { get }
  var method: Method { get }
  var parameters: Parameters { get }
}

extension Request {
  typealias Parameters = [String: Any]
  typealias Method = String
}

extension Method {
  static let get: String = "GET"
}

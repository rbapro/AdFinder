//
// RequestMock.swift
// 
//
// Created by ronael.bajazet on 08/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
@testable import WebProxy

struct RequestMock: Request {
  var path: String = ""
  var method: String = ""
  var parameters: Parameters = [:]
}

//
// AdsRepository.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities

protocol AdsRepository {
  func retrieve() async throws -> [AdEntity]
}

//
// AdsListInteractorInput.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

protocol AdsListInteractorInput: AnyObject {
  func retrieve() async
  func handleAd(with id: Int) async
}

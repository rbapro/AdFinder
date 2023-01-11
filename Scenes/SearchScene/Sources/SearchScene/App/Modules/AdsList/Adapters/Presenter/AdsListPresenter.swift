//
// AdsListPresenter.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

struct AdsListPresenterDependencies {
  let interactor: AdsListInteractorInput
}

final class AdsListPresenter {

  // MARK: - Properties

  let interactor: AdsListInteractorInput
  weak var output: AdsListPresenterOutput?

  // MARK: - Init

  init(dependencies: AdsListPresenterDependencies) {
    self.interactor = dependencies.interactor
  }
}

// MARK: - AdsListPresenterInput

extension AdsListPresenter: AdsListPresenterInput {
  func viewDidLoad() {
    // TODO: -
  }

  func didSelectAd() {
    // TODO: -
  }
}

// MARK: - AdsListInteractorOutput

extension AdsListPresenter: AdsListInteractorOutput {
  func notifyLoading() async {
    // TODO: -
  }

  func notify(category: AdsListInteractorCategory) async {
    // TODO: -
  }
}

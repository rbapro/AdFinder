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

  private let interactor: AdsListInteractorInput
  weak var output: AdsListPresenterOutput?

  // MARK: - Init

  init(dependencies: AdsListPresenterDependencies) {
    self.interactor = dependencies.interactor
  }
}

// MARK: - Private

extension AdsListPresenter {
  func convert(_ item: AdsListInteractorCategory.Ad) -> AdsListViewItem {
    .init(
      id: item.id,
      image: item.image.first?.small,
      category: item.category,
      title: item.title,
      // TODO: convert price
      price: String(item.price),
      urgentText: item.isUrgent ? "Dépêchez-vous !" : nil
    )
  }
}

// MARK: - AdsListPresenterInput

extension AdsListPresenter: AdsListPresenterInput {
  func viewDidLoad() {
    Task {
      await interactor.retrieve()
    }
  }

  func didSelectAd(with identifier: Int) {
    Task {
      await interactor.handleAd(with: identifier)
    }
  }
}

// MARK: - AdsListInteractorOutput

extension AdsListPresenter: AdsListInteractorOutput {
  @MainActor
  func notifyLoading() async {
    output?.showLoading()
  }

  @MainActor
  func notify(category: AdsListInteractorCategory) async {
    output?.hideLoading()
    switch category {
    case let .ads(items):
      let viewItems = items.map { convert($0) }
      output?.notiftList(with: viewItems)
    case .error:
      output?.notifyError()
    }
  }
}

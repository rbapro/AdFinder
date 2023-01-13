//
// AdDetailsPresenter.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

struct AdDetailsPresenterDependencies {
  let interactor: AdDetailsInteractorInput
  let priceFormatter: PriceFormatterProtocol
  let dateFormatter: DateFormatterProtocol
}

final class AdDetailsPresenter {

  // MARK: - Constants

  private enum Constants {
    static let createDateFormat: String = "MMM d, yyyy h:mm a"
  }

  // MARK: - Properties

  private let interactor: AdDetailsInteractorInput
  weak var output: AdDetailsPresenterOutput?
  private let priceFormatter: PriceFormatterProtocol
  private let dateFormatter: DateFormatterProtocol


  // MARK: - Init

  init(dependencies: AdDetailsPresenterDependencies) {
    interactor = dependencies.interactor
    priceFormatter = dependencies.priceFormatter
    dateFormatter = dependencies.dateFormatter
  }
}

// MARK: - Private

extension AdDetailsPresenter {
  func convert(_ item: AdDetailsInteractorCategory.Ad) -> AdDetailsViewItem {
    let formattedPrice = priceFormatter.format(price: item.price.amount,
                                               with: item.price.currencyCode)
    let formattedDate = dateFormatter.string(from: item.creationDate,
                                             withFormat: Constants.createDateFormat)

    return .init(
      image: item.images.first?.thumb ?? item.images.first?.small,
      title: item.title,
      price: formattedPrice,
      creationDate: formattedDate,
      category: item.category,
      descriptionTitle: "Description",
      description: item.description,
      urgentText: item.isUrgent ? "Dépêchez-vous !" : nil,
      siret: item.siret
    )
  }
}

// MARK: - AdDetailsInteractorInput

extension AdDetailsPresenter: AdDetailsPresenterInput {
  func viewDidLoad() {
    Task {
      await interactor.retrieve()
    }
  }

  func viewWillRefresh() {
    Task {
      await interactor.retrieve()
    }
  }
}

// MARK: - AdDetailsInteractorOutput

extension AdDetailsPresenter: AdDetailsInteractorOutput {
  @MainActor
  func notifyLoading() async {
    output?.showLoading()
  }

  @MainActor
  func notify(category: AdDetailsInteractorCategory) async {
    output?.hideLoading()

    switch category {
    case let .details(item):
      let viewItem = convert(item)
      output?.displayAd(with: viewItem)
    case .empty:
      output?.displayEmptyState()
    }
  }
}

//
// AdDetailsInteractor.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public struct AdDetailsInteractorDependencies {
  let adRepository: CurrentAdGettingRepository
}

final class AdDetailsInteractor {

  // MARK: - Constants

  private enum Constants {
    static let defaultCurrencyCode: String = "EUR"
  }

  // MARK: - Properties

  weak var output: AdDetailsInteractorOutput?
  private let repository: CurrentAdGettingRepository

  // MARK: - Init

  init(dependencies: AdDetailsInteractorDependencies) {
    repository = dependencies.adRepository
  }
}

// MARK: - Private

private extension AdDetailsInteractor {
  func notify(ad: CurrentAdRepositoryItem) async {
    let ad = AdDetailsInteractorCategory.Ad(
      id: ad.id,
      title: ad.title,
      description: ad.description,
      images: ad.images.map { .init(small: $0.small, thumb: $0.thumb) },
      price: .init(amount: ad.price, currencyCode: Constants.defaultCurrencyCode),
      creationDate: ad.creationDate,
      isUrgent: ad.isUrgent,
      category: ad.category,
      siret: ad.siret
    )
    await output?.notify(category: .details(ad))
  }
}

// MARK: - AdDetailsInteractorInput

extension AdDetailsInteractor: AdDetailsInteractorInput {
  func retrieve() async {
    await output?.notifyLoading()
    guard let ad = await repository.get() else {
      await output?.notify(category: .empty)
      return
    }
    await notify(ad: ad)
  }
}

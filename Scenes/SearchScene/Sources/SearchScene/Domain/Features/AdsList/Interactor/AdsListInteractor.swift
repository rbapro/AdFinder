//
// AdsListInteractor.swift
// 
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import Entities

struct AdsListInteractorDependencies {
  let dataSource: AdsListInteractorDataSource
  let router: AdsListRouting
  let adsRepository: AdsRepository
  let adCategoriesRepository: AdCategoriesRepository
  let currentAdRepository: CurrentAdSavingRepository
}

final class AdsListInteractor {

  // MARK: - Properties

  weak var output: AdsListInteractorOutput?

  private let dataSource: AdsListInteractorDataSource
  private let router: AdsListRouting
  private let adsRepository: AdsRepository
  private let adCategoriesRepository: AdCategoriesRepository
  private let currentAdRepository: CurrentAdSavingRepository

  // MARK: - Init

  init(dependencies: AdsListInteractorDependencies) {
    dataSource = dependencies.dataSource
    router = dependencies.router
    adsRepository = dependencies.adsRepository
    adCategoriesRepository = dependencies.adCategoriesRepository
    currentAdRepository = dependencies.currentAdRepository
  }
}

// MARK: - Private

private extension AdsListInteractor {
  func handle(ads: [AdEntity], categories: AdCategories) async {
    dataSource.fetchedAds = ads
    dataSource.fetchedAdCategories = categories
    
    let ads: [AdsListInteractorCategory.Ad] = ads.compactMap { ad -> AdsListInteractorCategory.Ad? in
      guard let category = categories[ad.categoryId] else {
        return nil
      }
      return AdsListInteractorCategory.Ad(
        id: ad.id,
        title: ad.title,
        image: ad.images.map {
          AdsListInteractorCategory.Ad.Image(small: $0.small, thumb: $0.thumb)
        },
        price: ad.price,
        isUrgent: ad.isUrgent,
        category: category
      )
    }
    await output?.notify(category: .ads(ads))
  }
}

// MARK: - AdsListInteractorInput

extension AdsListInteractor: AdsListInteractorInput {
  func retrieve() async {
    await output?.notifyLoading()

    do {
      async let ads = adsRepository.retrieve()
      async let categories = adCategoriesRepository.retrieve()
      await handle(ads: try ads, categories: try categories)
    } catch {
      await output?.notify(category: .error)
    }
  }

  func handleAd(with id: Int) async {
    guard let ad = dataSource.fetchedAds.first(where: { $0.id == id }),
          let category = dataSource.fetchedAdCategories[ad.categoryId] else {
      return
    }

    let item = CurrentAdRepositoryItem(
      id: ad.id,
      title: ad.title,
      description: ad.description,
      price: ad.price,
      images: ad.images.map { ($0.small, $0.thumb) },
      creationDate: ad.creationDate,
      isUrgent: ad.isUrgent,
      siret: ad.siret,
      category: category
    )
    await currentAdRepository.save(ad: item)
    await router.routeToDetails()
  }
}

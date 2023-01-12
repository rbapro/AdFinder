//
// AdsListFactory.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import WebProxy
import UIKit

protocol AdsListFactoryProtocol {
  func makeView() -> UIViewController
}

final class AdsListFactory {}

// MARK: - AdsListFactoryProtocol

extension AdsListFactory: AdsListFactoryProtocol {
  func makeView() -> UIViewController {
    let view = AdsListViewController()

    let adsRepository = AdsNetworkRepository(service: WebProxyWrapper.shared.adsService)
    let adCategoriesRepository = AdCategoriesNetworkRepository(service: WebProxyWrapper.shared.adCategoriesService)

    let interactorDependencies = AdsListInteractorDependencies(
      dataSource: AdsListInteractorDataSource(),
      router: AdsListRouter(),
      adsRepository: adsRepository,
      adCategoriesRepository: adCategoriesRepository,
      currentAdRepository: CurrentAdSharedRepository.shared
    )
    let interactor = AdsListInteractor(dependencies: interactorDependencies)

    let presenter = AdsListPresenter(
      dependencies: AdsListPresenterDependencies(interactor: interactor,
                                                 priceFormatter: PriceFormatter())
    )
    presenter.output = view
    interactor.output = presenter
    view.presenter = presenter

    return UINavigationController(rootViewController: view)
  }
}

//
// AdDetailsFactory.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit

protocol AdDetailsFactoryProtocol {
  func makeView() -> AdDetailsViewProtocol
}

final class AdDetailsFactory {}

// MARK: - AdDetailsFactoryProtocol

extension AdDetailsFactory: AdDetailsFactoryProtocol {
  func makeView() -> AdDetailsViewProtocol {
    let view = AdDetailsViewController()

    let interactorDependencies = AdDetailsInteractorDependencies(
      adRepository: CurrentAdSharedRepository.shared
    )
    let interactor = AdDetailsInteractor(dependencies: interactorDependencies)

    let presenter = AdDetailsPresenter(
      dependencies: AdDetailsPresenterDependencies(interactor: interactor,
                                                   priceFormatter: PriceFormatter(),
                                                   dateFormatter: AFDateFormatter())
    )
    presenter.output = view
    interactor.output = presenter
    view.presenter = presenter

    return view
  }
}

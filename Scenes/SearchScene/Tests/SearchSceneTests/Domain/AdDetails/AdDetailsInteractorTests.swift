//
// AdDetailsInteractorTests.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import XCTest
@testable import SearchScene

final class AdDetailsInteractorTests: XCTestCase {

  private var sut: AdDetailsInteractor!
  private var repository: CurrentAdGettingRepositoryMock!
  private var output: AdDetailsInteractorOutputMock!

  override func setUp() async throws {
    try await super.setUp()

    repository = CurrentAdGettingRepositoryMock()

    let dependencies = AdDetailsInteractorDependencies(
      adRepository: repository
    )
    sut = AdDetailsInteractor(dependencies: dependencies)

    output = AdDetailsInteractorOutputMock()
    sut.output = output
  }

  override func tearDown() async throws {
    repository = nil
    output = nil
    sut = nil

    try await super.tearDown()
  }

  // MARK: - Tests

  // MARK: retrieve

  func test_retrieve_whenDataIsRetrieved_thenNotifyAd() async {
    // GIVEN: user access ad details AND the there is an ad
    repository.getAdReturnValue = .init(
      id: 1077103477,
      title: "Ad 2 title",
      description: "Ad 2 description",
      price: 39000.00,
      images: [
        (small: URL(string: "https://www.images.com/leboncoin/3746d8b740311.jpg"), thumb: nil)
      ],
      creationDate: Date(day: 01, month: 09, year: 2023)!,
      isUrgent: false,
      siret: "549 548 200",
      category: "Multimédia"
    )

    // WHEN: retrieving data
    await sut.retrieve()

    // THEN:
    XCTAssertTrue(output.invokedNotifyLoading)

    XCTAssertTrue(repository.invokedGet)

    XCTAssertTrue(output.invokedNotifyCategory)
    let expectedAd: AdDetailsInteractorCategory.Ad = .init(
      id: 1077103477,
      title: "Ad 2 title",
      description: "Ad 2 description",
      images: [
        .init(small: URL(string: "https://www.images.com/leboncoin/3746d8b740311.jpg"), thumb: nil)
      ],
      price: .init(amount: 39000.00, currencyCode: "EUR"),
      creationDate: Date(day: 01, month: 09, year: 2023)!,
      isUrgent: false,
      category: "Multimédia",
      siret: "549 548 200"
    )
    XCTAssertEqual(output.invokedNotifyCategoryParameter, .details(expectedAd))
  }

  func test_retrieve_whenRetrieveNoAd_thenNotifyEmpty() async {
    // GIVEN: user access ad details AND the there is no ad
    repository.getAdReturnValue = nil

    // WHEN: retrieving data
    await sut.retrieve()

    // THEN:
    XCTAssertTrue(output.invokedNotifyLoading)
    XCTAssertTrue(repository.invokedGet)
    XCTAssertTrue(output.invokedNotifyCategory)
    XCTAssertEqual(output.invokedNotifyCategoryParameter, .empty)
  }
}

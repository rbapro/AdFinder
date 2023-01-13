//
// AdsListInteractorTests.swift
//
//
// Created by ronael.bajazet on 10/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import XCTest
import Entities
@testable import SearchScene

final class AdsListInteractorTests: XCTestCase {

  private var sut: AdsListInteractor!
  private var dataSource: AdsListInteractorDataSource!
  private var output: AdsListInteractorOutputMock!
  private var router: AdsListRoutingMock!
  private var adsRepository: AdsRepositoryMock!
  private var adCategoriesRepository: AdCategoriesRepositoryMock!
  private var currentAdRepository: CurrentAdSavingRepositoryMock!

  override func setUpWithError() throws {
    dataSource = AdsListInteractorDataSource()
    output = AdsListInteractorOutputMock()
    router = AdsListRoutingMock()
    adsRepository = AdsRepositoryMock()
    adCategoriesRepository = AdCategoriesRepositoryMock()
    currentAdRepository = CurrentAdSavingRepositoryMock()
    sut = AdsListInteractor(dependencies: .init(
      dataSource: dataSource,
      router: router,
      adsRepository: adsRepository,
      adCategoriesRepository: adCategoriesRepository,
      currentAdRepository: currentAdRepository
    ))
    sut.output = output
  }

  override func tearDownWithError() throws {
    dataSource = nil
    output = nil
    router = nil
    adsRepository = nil
    adCategoriesRepository = nil
    currentAdRepository = nil
    sut = nil
  }

  // MARK: - Tests

  // MARK: retrieve

  func test_retrieve_whenRetrieveAdsWithMatchingCategories_thenNotifyAdsSortedByDate() async {
    // GIVEN: user access ads list AND there is available ads
    adsRepository.retrieveReturnValue = AdEntityMock.makeStubs()
    adCategoriesRepository.retrieveReturnValue = AdCategoryMock.makeStubs()

    // WHEN: retrieving data
    await sut.retrieve()

    // THEN:
    XCTAssertTrue(output.invokedNotifyLoading)

    XCTAssertTrue(adsRepository.invokedRetrieve)
    XCTAssertTrue(adCategoriesRepository.invokedRetrieve)

    XCTAssertTrue(output.invokedNotify)
    let expectedAds: [AdsListInteractorCategory.Ad] = [
      .init(
        id: 1671026575,
        title: "Ad 3 title",
        image: [
          .init(small: URL(string: "https://www.images.com/leboncoin/a3b3692f.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/af9c43ff5a3b.jpg"))
        ],
        price: .init(amount: 1150.00, currencyCode: "EUR"),
        isUrgent: false,
        category: "Multimédia"
      ),
      .init(
        id: 1664493117,
        title: "Ad 1 title",
        image: [
          .init(small: URL(string: "https://www.images.com/leboncoin/43ff5a3b3692f.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a3b3692f43f.jpg"))
        ],
        price: .init(amount: 25.00, currencyCode: "EUR"),
        isUrgent: false,
        category: "Service"
      ),
      .init(
        id: 1701863683,
        title: "Ad 4 title",
        image: [
          .init(small: URL(string: "https://www.images.com/leboncoin/8b740311.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a3b38b740f9c4.jpg"))
        ],
        price: .init(amount: 47.00, currencyCode: "EUR"),
        isUrgent: false,
        category: "Immobilier"
      ),
      .init(
        id: 1077103477,
        title: "Ad 2 title",
        image: [
          .init(small: URL(string: "https://www.images.com/leboncoin/3746d8b740311.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a46d8b71192f3f.jpg"))
        ],
        price: .init(amount: 39000.00, currencyCode: "EUR"),
        isUrgent: true,
        category: "Véhicule"
      )
    ]
    XCTAssertEqual(output.invokedNotifyParameters?.category, .ads(expectedAds))
  }

  func test_retrieve_whenRetrieveAdsWithSomeUnmatchingCategories_thenNotifyAdsSortedByDate() async {
    // GIVEN: user access ads list AND there is available ads
    adsRepository.retrieveReturnValue = AdEntityMock.makeStubs(setInvalidCategories: true)
    adCategoriesRepository.retrieveReturnValue = AdCategoryMock.makeStubs()

    // WHEN: retrieving data
    await sut.retrieve()

    // THEN:
    XCTAssertTrue(output.invokedNotifyLoading)

    XCTAssertTrue(adsRepository.invokedRetrieve)
    XCTAssertTrue(adCategoriesRepository.invokedRetrieve)

    XCTAssertTrue(output.invokedNotify)
    let expectedAds: [AdsListInteractorCategory.Ad] = [
      .init(
        id: 1671026575,
        title: "Ad 3 title",
        image: [
          .init(small: URL(string: "https://www.images.com/leboncoin/a3b3692f.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/af9c43ff5a3b.jpg"))
        ],
        price: .init(amount: 1150.00, currencyCode: "EUR"),
        isUrgent: false,
        category: "Multimédia"
      ),
      .init(
        id: 1664493117,
        title: "Ad 1 title",
        image: [
          .init(small: URL(string: "https://www.images.com/leboncoin/43ff5a3b3692f.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a3b3692f43f.jpg"))
        ],
        price: .init(amount: 25.00, currencyCode: "EUR"),
        isUrgent: false,
        category: "Service"
      )
    ]
    XCTAssertEqual(output.invokedNotifyParameters?.category, .ads(expectedAds))
  }

  func test_retrieve_whenAnErrorOccurs_thenNotifyError() async {
    // GIVEN: user access ads list AND there is an loading error
    enum RepositoryError: Error {
      case network
    }
    adsRepository.retrieveThrowableError = RepositoryError.network
    adCategoriesRepository.retrieveReturnValue = AdCategoryMock.makeStubs()

    // WHEN: retrieving data
    await sut.retrieve()

    // THEN:
    XCTAssertTrue(output.invokedNotifyLoading)

    XCTAssertTrue(adsRepository.invokedRetrieve)
    XCTAssertTrue(adCategoriesRepository.invokedRetrieve)

    XCTAssertTrue(output.invokedNotify)
    XCTAssertEqual(output.invokedNotifyParameters?.category, .error)
  }

  // MARK: handleAd

  func test_handleAd_whenHandlingExistingAd_thenRouteToDetail() async {
    // GIVEN: user had accessed ads list
    dataSource.fetchedAds = AdEntityMock.makeStubs()
    dataSource.fetchedAdCategories = AdCategoryMock.makeStubs()

    // WHEN: handling ad selection
    await sut.handleAd(with: 1664493117)

    // THEN: output is not called
    XCTAssertFalse(output.invokedNotifyLoading)
    XCTAssertFalse(output.invokedNotify)

    // THEN: save current ad
    XCTAssertTrue(currentAdRepository.invokedSave)
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.id, 1664493117)
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.title, "Ad 1 title")
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.description, "Ad 1 description")
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.price, 25.0)
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.images.count, 1)
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.images.first?.small, URL(string: "https://www.images.com/leboncoin/43ff5a3b3692f.jpg"))
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.images.first?.thumb, URL(string: "https://www.images.com/leboncoin/a3b3692f43f.jpg"))
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.creationDate, Date(day: 10, month: 10, year: 2023))
    XCTAssertFalse(currentAdRepository.invokedSaveParameters!.ad.isUrgent)
    XCTAssertNil(currentAdRepository.invokedSaveParameters?.ad.siret)
    XCTAssertEqual(currentAdRepository.invokedSaveParameters?.ad.category, "Service")

    // THEN: route to details
    XCTAssertTrue(router.invokedRouteToDetails)
  }

  func test_handleAd_whenHandlingInvalidAd_thenDoNothing() async {
    // GIVEN: user had accessed ads list
    dataSource.fetchedAds = AdEntityMock.makeStubs()
    dataSource.fetchedAdCategories = AdCategoryMock.makeStubs()

    // WHEN: handling ad selection
    await sut.handleAd(with: 133)

    // THEN: nothing is done
    XCTAssertFalse(output.invokedNotifyLoading)
    XCTAssertFalse(output.invokedNotify)
    XCTAssertFalse(currentAdRepository.invokedSave)
    XCTAssertFalse(router.invokedRouteToDetails)
  }
}

// MARK: - Stubs

extension AdEntityMock {
  static func makeStubs(setInvalidCategories: Bool = false) -> [AdEntityMock] {
    [
      .init(
        id: 1664493117,
        categoryId: 9,
        title: "Ad 1 title",
        description: "Ad 1 description",
        price: 25.00,
        images: [
          .init(small: URL(string: "https://www.images.com/leboncoin/43ff5a3b3692f.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a3b3692f43f.jpg"))
        ],
        creationDate: Date(day: 10, month: 10, year: 2023)!,
        isUrgent: false,
        siret: nil
      ),
      .init(
        id: 1077103477,
        categoryId: setInvalidCategories ? 21 : 1,
        title: "Ad 2 title",
        description: "Ad 2 description",
        price: 39000.00,
        images: [
          .init(small: URL(string: "https://www.images.com/leboncoin/3746d8b740311.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a46d8b71192f3f.jpg"))
        ],
        creationDate: Date(day: 01, month: 09, year: 2023)!,
        isUrgent: true,
        siret: nil
      ),
      .init(
        id: 1671026575,
        categoryId: 8,
        title: "Ad 3 title",
        description: "Ad 3 description",
        price: 1150.00,
        images: [
          .init(small: URL(string: "https://www.images.com/leboncoin/a3b3692f.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/af9c43ff5a3b.jpg"))
        ],
        creationDate: Date(day: 04, month: 11, year: 2023)!,
        isUrgent: false,
        siret: "431 342 910"
      ),
      .init(
        id: 1701863683,
        categoryId: setInvalidCategories ? 42 : 6,
        title: "Ad 4 title",
        description: "Ad 4 description",
        price: 47.00,
        images: [
          .init(small: URL(string: "https://www.images.com/leboncoin/8b740311.jpg"),
                thumb: URL(string: "https://www.images.com/leboncoin/a3b38b740f9c4.jpg"))
        ],
        creationDate: Date(day: 9, month: 10, year: 2023)!,
        isUrgent: false,
        siret: nil
      )
    ]
  }
}

extension AdCategoryMock {
  static func makeStubs() -> AdCategories {
    [
      1: "Véhicule",
      3: "Bricolage",
      5: "Loisirs",
      6: "Immobilier",
      8: "Multimédia",
      9: "Service"
    ]
  }
}

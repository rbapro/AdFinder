//
// NetworkClientTests.swift
// 
//
// Created by ronael.bajazet on 08/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import XCTest
@testable import WebProxy

final class NetworkClientTests: XCTestCase {

  private var sut: NetworkClient!
  private var session: NetworkSessionMock!

  override func setUp() async throws {
    try await super.setUp()

    let configuration = NetworkConfiguration(baseUrl: "https://www.base.url")
    session = NetworkSessionMock(configuration: configuration)
    sut = NetworkClient(session: session)
  }

  override func tearDown() async throws {
    session = nil
    sut = nil
    
    try await super.tearDown()
  }

  // MARK: - Tests

  // MARK: fetch

  func test_fetch_sessionReturnData_thenShouldReturnModel() async throws {
    session.executeRequestReturnValue = "{\"message\": \"Bonjour\"}".data(using: .utf8)!

    let model: TestModel = try await sut.fetch(request: RequestMock())

    XCTAssertNoThrow("should not throws error")
    XCTAssertEqual(model.message, "Bonjour")
  }

  func test_fetch_sessionThrowError_thenShouldThrowError() async {
    session.executeRequestThrowableError = URLError(.unsupportedURL)

    do {
      let _: TestModel = try await sut.fetch(request: RequestMock())
    } catch {
      XCTAssertEqual(error._code, URLError(.unsupportedURL).errorCode)
      XCTAssertEqual(error.localizedDescription, URLError(.unsupportedURL).localizedDescription)
    }
  }
}

private struct TestModel: Decodable {
  let message: String?
}

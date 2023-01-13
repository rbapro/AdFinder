//
// WebProxyWrapper.swift
// 
//
// Created by ronael.bajazet on 08/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

public final class WebProxyWrapper {

  // MARK: - Singleton

  public static let shared = WebProxyWrapper()
  private init() {}

  // MARK: - Properties

  private(set) var environment: EnvironmentProvider?

  private lazy var client: Network = {
    let configuration = NetworkConfiguration(baseUrl: environment?.baseUrl ?? "")
    let session = URLSessionClient(configuration: configuration)
    return NetworkClient(session: session)
  }()

  // MARK: - Services

  public lazy var adsService: GetAdsServiceProtocol = GetAdsService(client: client)
  public lazy var adCategoriesService: GetAdCategoriesServiceProtocol = GetAdCategoriesService(client: client)

  // MARK: - Methods

  public func set(environment: EnvironmentProvider) {
    self.environment = environment
  }
}

//
// URLSessionClient.swift
// 
//
// Created by ronael.bajazet on 07/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation

class URLSessionClient {

  // MARK: - Properties

  private let configuration: NetworkConfiguration

  // MARK: - Init

  required init(configuration: NetworkConfiguration) {
    self.configuration = configuration
  }
}

// MARK: - Private

private extension URLSessionClient {
  
  // MARK: - Methods

  func makeEndpoint(from request: Request) -> String {
    var baseUrl = configuration.baseUrl
    if baseUrl.hasSuffix("/") {
      baseUrl.removeLast()
    }
    var path = request.path
    if path.hasPrefix("/") {
      path.removeFirst()
    }

    return "\(baseUrl)/\(path)"
  }

  func validate(response: URLResponse) throws {
    // TODO: validate response before returning data
  }
}

// MARK: - NetworkSession

extension URLSessionClient: NetworkSession {
  func execute(request: some Request) async throws -> Data {
    let endpoint = makeEndpoint(from: request)

    guard var urlComponents = URLComponents(string: endpoint) else {
      throw URLError(.badURL)
    }

    urlComponents.queryItems = request.parameters.map {
      URLQueryItem(name: $0.key, value: String(describing: $0.value))
    }

    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method

    let (data, response) = try await URLSession.shared.data(for: urlRequest)

    try validate(response: response)

    return data
  }
}

// MARK: - URLSession async/await

private extension URLSession {
  func data(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
    var task: URLSessionDataTask?

    return try await withTaskCancellationHandler {
      try await withCheckedThrowingContinuation { continuation in
        task = self.dataTask(with: request) { data, response, error in
          guard let data = data, let response = response else {
            let error = error ?? URLError(.unknown)
            return continuation.resume(throwing: error)
          }

          continuation.resume(returning: (data, response))
        }

        task?.resume()
      }
    } onCancel: { [weak task] in
      task?.cancel()
    }
  }
}

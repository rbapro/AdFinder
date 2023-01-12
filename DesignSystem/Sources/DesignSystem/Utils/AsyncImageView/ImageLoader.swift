//
// ImageLoader.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit
import Combine

public final class ImageLoader {

  // MARK: - Contants

  private enum Constants {
    static let validHttpStatusCodeRange = (200..<300)
  }

  // MARK: - Properties

  private static let cache: NSCache<NSURL, UIImage> = {
    let cache = NSCache<NSURL, UIImage>()
    cache.countLimit = 100
    cache.totalCostLimit = 1024 * 1024 * 100
    return cache
  }()

  @Published private(set) var image: UIImage?
  @Published private(set) var isLoading: Bool = false

  private var task: AnyCancellable?

  private static let imageLoadingQueue: DispatchQueue = .init(label: "com.imageLoading.queue")


  // MARK: - Init

  public init() {}

  deinit {
    cancel()
  }

  // MARK: - Methods

  public func cancel() {
    task?.cancel()
  }

  public func load(image url: URL) {
    isLoading = true

    if let image = ImageLoader.cache.object(forKey: url as NSURL) {
      isLoading = false
      self.image = image
      return
    }

    task = URLSession.shared.dataTaskPublisher(for: url).map { (data: Data, response: URLResponse) -> UIImage? in
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
            Constants.validHttpStatusCodeRange.contains(statusCode)
      else { return nil }
      return UIImage(data: data)
    }
    .replaceError(with: nil)
    .handleEvents(
      receiveSubscription: { [weak self] _ in
        self?.isLoading = true
      },
      receiveOutput: {
        guard let image = $0 else {
          Self.cache.removeObject(forKey: url as NSURL)
          return
        }
        Self.cache.setObject(image, forKey: url as NSURL)
      },
      receiveCompletion: { [weak self] _ in
        self?.isLoading = false
      },
      receiveCancel: { [weak self] in
        self?.isLoading = false
      }
    )
    .subscribe(on: Self.imageLoadingQueue)
    .receive(on: DispatchQueue.main)
    .sink { [weak self] in
      self?.image = $0
    }
  }
}

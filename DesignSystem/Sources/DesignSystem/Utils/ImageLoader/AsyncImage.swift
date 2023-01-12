//
// AsyncImage.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import UIKit
import Combine

public final class AsyncImage: UIImageView, ViewLoadable {

  // MARK: - ViewLoadable properties

  public lazy var loadingView: UIActivityIndicatorView? = activityIndicator
  public var viewsToHideWhenLoading: [UIView] { [] }

  // MARK: - Properties

  private lazy var loader = ImageLoader()
  private var imageCancellable: AnyCancellable?
  private var loadingCancellable: AnyCancellable?

  // MARK: - Deinit

  deinit {
    cancel()
  }

  // MARK: - Methods

  public func load(image url: URL,
                   placeholder: UIImage? = nil) {
    loader.load(image: url)
    subscribeToImageUpdate(placeholder)
    subscribeToLoadingState()
  }

  public func cancel() {
    stopLoading()
    loader.cancel()
    imageCancellable?.cancel()
    loadingCancellable?.cancel()
  }

  // MARK: - Private

  private func subscribeToImageUpdate(_ placeholder: UIImage?) {
    imageCancellable = loader.$image.sink { [weak self] image in
      guard let self else { return }
      DispatchQueue.main.async {
        if let image {
          self.image = image
        } else {
          self.image = placeholder
        }
      }
    }
  }

  private func subscribeToLoadingState() {
    loadingCancellable = loader.$isLoading.sink { [weak self] isLoading in
      guard let self else { return }
      DispatchQueue.main.async {
        if isLoading {
          self.image = nil
          self.startLoading()
        } else {
          self.stopLoading()
        }
      }
    }
  }
}

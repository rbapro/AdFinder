//
// ViewLoadable.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
  var activityIndicator: UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.hidesWhenStopped = true
    activityIndicator.color = .adAccentPrimary
    self.addSubview(activityIndicator)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    self.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
    self.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor).isActive = true

    return activityIndicator
  }
}

public protocol ViewLoadable {
  var loadingView: UIActivityIndicatorView? { get set }
  var viewsToHideWhenLoading: [UIView] { get }
  func startLoading()
  func stopLoading()
}

public extension ViewLoadable {
  func startLoading() {
    viewsToHideWhenLoading.forEach {
      $0.isHidden = true
    }
    loadingView?.startAnimating()
  }

  func stopLoading() {
    viewsToHideWhenLoading.forEach {
      $0.isHidden = false
    }
    loadingView?.stopAnimating()
  }
}

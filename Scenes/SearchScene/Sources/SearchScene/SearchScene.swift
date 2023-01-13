//
// SearchScene.swift
// 
//
// Created by ronael.bajazet on 07/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit

final class SearchScene: NSObject {
  public func make() -> UIViewController {
    SearchSplitViewController(style: .doubleColumn)
  }
}

private final class SearchSplitViewController: UISplitViewController {

  lazy var listView = AdsListFactory().makeView()
  lazy var detailsView = AdDetailsFactory().makeView()

  override init(style: UISplitViewController.Style) {
    super.init(style: style)

    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }

  private func setup() {
    preferredDisplayMode = .oneBesideSecondary
    presentsWithGesture = false

    delegate = self

    preferredPrimaryColumnWidthFraction = 0.4
    minimumPrimaryColumnWidth = view.bounds.size.width * 0.3
    maximumPrimaryColumnWidth = view.bounds.size.width

    view.backgroundColor = .systemBackground

    setViewController(listView, for: .primary)
    setViewController(detailsView, for: .secondary)
  }

  override func show(_ column: UISplitViewController.Column) {
    super.show(column)
    switch column {
    case .secondary:
      detailsView.refreshView()
    default: break
    }
  }
}

// MARK: - UISplitViewControllerDelegate

extension SearchSplitViewController: UISplitViewControllerDelegate {
  func splitViewController(
    _ svc: UISplitViewController,
    topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
  ) -> UISplitViewController.Column {
    .primary
  }
}

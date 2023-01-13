//
// AdsListViewController.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit
import DesignSystem

class AdsListViewController: UIViewController, ViewLoadable {

  // MARK: - ViewLoadable properties

  lazy var loadingView: UIActivityIndicatorView? = view.activityIndicator
  var viewsToHideWhenLoading: [UIView] {
    [collectionView]
  }

  // MARK: - Properties

  var presenter: AdsListPresenterInput!

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: makeViewLayout())

    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    return collectionView
  }()

  private lazy var dataSource = makeDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    presenter.viewDidLoad()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView.collectionViewLayout.invalidateLayout()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
  }
}

// MARK: - AdsListPresenterOutput

extension AdsListViewController: AdsListPresenterOutput {
  func showLoading() {
    startLoading()
  }

  func hideLoading() {
    stopLoading()
  }

  func notiftList(with items: [AdsListViewItem]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, AdsListViewItem>()
    snapshot.appendSections([0])
    snapshot.appendItems(items.map { $0 })
    dataSource.apply(snapshot)
  }

  func notifyError() {
    // TODO: -
  }
}

// MARK: - Private

private extension AdsListViewController {
  func setupView() {
    title = "Annonces"
    loadingView = view.activityIndicator
    collectionView.delegate = self
  }

  // MARK: CollectionView configuration

  func makeViewLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                             heightDimension: .fractionalWidth(0.7))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 2)

      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }

  func makeCellRegistration() -> UICollectionView.CellRegistration<AdsListCollectionViewCell, AdsListViewItem> {
    .init { cell, _, ad in
      cell.configure(with: ad)
    }
  }

  private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, AdsListViewItem> {
    let cell = makeCellRegistration()

    return UICollectionViewDiffableDataSource<Int, AdsListViewItem>(collectionView: collectionView) { [weak self]
      collectionView, indexPath, identifier -> UICollectionViewCell in
      let item = self?.dataSource.itemIdentifier(for: indexPath)
      return collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: item)
    }
  }
}

// MARK: - UICollectionViewDelegate

extension AdsListViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    presenter.didSelectAd(with: item.id)
  }
}

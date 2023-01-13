//
// AdDetailsViewController.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit
import DesignSystem

protocol AdDetailsViewProtocol: UIViewController {
  func refreshView()
}

class AdDetailsViewController: UIViewController, ViewLoadable {

  // MARK: - ViewLoadable properties

  lazy var loadingView: UIActivityIndicatorView? = view.activityIndicator

  var viewsToHideWhenLoading: [UIView] {
    [scrollView]
  }

  // MARK: - Properties

  private lazy var scrollView: UIScrollView = makeScrollView()
  private lazy var imageView: AsyncImageView = makeImageView()
  private lazy var titleLabel: UILabel = makeLabel(numberOfLines: 2, font: .descriptionBold)
  private lazy var priceLabel: UILabel = makeLabel(numberOfLines: 1, font: .descriptionBold)
  private lazy var creationDateLabel: UILabel = makeLabel(numberOfLines: 1, font: .caption)
  private lazy var categoryLabel: UILabel = makeLabel(numberOfLines: 1)
  private lazy var descriptionTitleLabel: UILabel = makeLabel(numberOfLines: 1, font: .descriptionBold)
  private lazy var descriptionLabel: UILabel = makeLabel(numberOfLines: 0)
  private lazy var urgentBadgeView: BadgeView = makeUrgentBadge()
  private lazy var siretLabel: UILabel = makeLabel(numberOfLines: 1, font: .caption)
  private lazy var contentStackView: UIStackView = makeStackView()

  var presenter: AdDetailsPresenterInput!

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    presenter.viewDidLoad()
  }
}

// MARK: - AdDetailsViewProtocol

extension AdDetailsViewController: AdDetailsViewProtocol {
  func refreshView() {
    presenter.viewWillRefresh()
  }
}

// MARK: - AdDetailsPresenterOutput

extension AdDetailsViewController: AdDetailsPresenterOutput {
  func showLoading() {
    startLoading()
  }

  func hideLoading() {
    stopLoading()
  }

  func displayAd(with item: AdDetailsViewItem) {
    setupContentView(with: item)
  }

  func displayEmptyState() {
    // TODO: -
  }
}

// MARK: - Private

private extension AdDetailsViewController {

  // MARK: - Private methods

  func setupContentView(with item: AdDetailsViewItem) {
    imageView.cancel()
    if let imageUrl = item.image {
      imageView.load(image: imageUrl)
    }
    if let text = item.urgentText {
      urgentBadgeView.isHidden = false
      urgentBadgeView.set(text: text)
    } else {
      urgentBadgeView.isHidden = true
    }

    titleLabel.text = item.title
    priceLabel.text = item.price
    creationDateLabel.text = item.creationDate
    categoryLabel.text = item.category
    descriptionTitleLabel.text = item.descriptionTitle
    descriptionLabel.text = item.description
    siretLabel.text = item.siret
  }

  // MARK: - Subviews

  func makeScrollView() -> UIScrollView {
    let scrollView = UIScrollView()
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    let horizontalPadding: CGFloat = 16
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: horizontalPadding
      ),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -horizontalPadding
      ),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    return scrollView
  }

  func makeStackView() -> UIStackView {
    let stack = UIStackView()
    stack.distribution = .fillProportionally
    stack.alignment = .fill
    stack.axis = .vertical
    stack.spacing = 16

    scrollView.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      stack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
    ])

    return stack
  }

  func makeImageView() -> AsyncImageView {
    let imageView = AsyncImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleToFill
    contentStackView.addArrangedSubview(imageView)
    return imageView
  }

  func makeUrgentBadge() -> BadgeView {
    let badge = BadgeView()
    imageView.addSubview(badge)
    badge.translatesAutoresizingMaskIntoConstraints = false
    let padding: CGFloat = 8
    NSLayoutConstraint.activate([
      badge.topAnchor.constraint(equalTo: imageView.topAnchor, constant: padding),
      badge.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -padding)
    ])
    return badge
  }

  func makeLabel(numberOfLines: Int, font: UIFont? = nil) -> UILabel {
    let label = UILabel()
    label.numberOfLines = numberOfLines
    label.font = font
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    contentStackView.addArrangedSubview(label)
    return label
  }
}

//
// AdsListCollectionViewCell.swift
// 
//
// Created by ronael.bajazet on 11/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

final class AdsListCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  private lazy var stackView: UIStackView = makeStackView()
  private lazy var imageView: AsyncImageView = makeImageView()
  private lazy var titleLabel: UILabel = makeTitleLabel()
  private lazy var priceLabel: UILabel = makePriceLabel()
  private lazy var categoryLabel: UILabel = makeCategoryLabel()
  private lazy var urgentBadge: BadgeView = makeUrgentBadge()

  // MARK: - Methods

  func configure(with item: AdsListViewItem) {
    imageView.cancel()
    if let image = item.image {
      imageView.load(image: image)
    }
    titleLabel.text = item.title
    priceLabel.text = item.price
    categoryLabel.text = item.category
    resetBadge(with: item.urgentText)
  }

  // MARK: - Private methods

  private func resetBadge(with text: String?) {
    if let urgentText = text {
      urgentBadge.isHidden = false
      urgentBadge.set(text: urgentText)
    } else {
      urgentBadge.isHidden = true
    }
  }
}

// MARK: - Views

private extension AdsListCollectionViewCell {
  func makeStackView() -> UIStackView {
    let stack = UIStackView()
    stack.distribution = .fillProportionally
    stack.alignment = .fill
    stack.axis = .vertical
    stack.spacing = 4

    contentView.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stack.topAnchor.constraint(equalTo: contentView.topAnchor),
      stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])

    return stack
  }

  func makeImageView() -> AsyncImageView {
    let imageView = AsyncImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    stackView.addArrangedSubview(imageView)
    return imageView
  }

  func makeTitleLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .descriptionBold
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    stackView.addArrangedSubview(label)
    return label
  }

  func makePriceLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .descriptionBold
    label.textColor = .adAccentPrimary
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    stackView.addArrangedSubview(label)
    return label
  }

  func makeCategoryLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .caption
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    stackView.addArrangedSubview(label)
    return label
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
}

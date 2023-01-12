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

// TODO: - Rework cell view

final class AdsListCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  private lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.distribution = .fill
    stack.alignment = .fill
    stack.axis = .vertical
    stack.spacing = 4

    contentView.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: 0
      ),
      stack.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: 0
      ),
      stack.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: 0
      ),
      stack.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: 0
      ),
      stack.widthAnchor.constraint(
        equalTo: contentView.widthAnchor
      )
    ])

    return stack
  }()

  private lazy var imageView: AsyncImage = {
    let imageView = AsyncImage()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    stackView.addArrangedSubview(imageView)
    return imageView
  }()

  private lazy var title: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 17)
    stackView.addArrangedSubview(label)
    return label
  }()

  private lazy var price: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .boldSystemFont(ofSize: 17)
    label.textColor = .orange
    stackView.addArrangedSubview(label)
    return label
  }()

  private lazy var category: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 13)
    stackView.addArrangedSubview(label)
    return label
  }()

  private lazy var urgent: BadgeView = {
    let badge = BadgeView()

    imageView.addSubview(badge)
    badge.translatesAutoresizingMaskIntoConstraints = false
    badge.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8.0).isActive = true
    badge.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8.0).isActive = true

    return badge
  }()

  // MARK: - Methods

  func configure(with item: AdsListViewItem) {
    imageView.cancel()
    if let image = item.image {
      imageView.load(image: image)
    }
    title.text = item.title
    price.text = item.price
    category.text = item.category
    if let urgentText = item.urgentText {
      urgent.isHidden = false
      urgent.set(text: urgentText)
    } else {
      urgent.isHidden = true
    }
    layoutSubviews()
  }
}

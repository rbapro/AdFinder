//
// BadgeView.swift
// 
//
// Created by ronael.bajazet on 12/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit

// TODO: - Fix layout in collectionview

public final class BadgeView: UIView {

  // MARK: - Properties

  private lazy var label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .boldSystemFont(ofSize: 11)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()

  // MARK: - Init

  public required init() {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  public func set(text: String) {
    label.text = text
  }
}

// MARK: - Private

extension BadgeView {
  private func setupView() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
    ])

    layer.borderWidth = 1
    layer.cornerRadius = 10
    // TODO: - review
    layer.borderColor = UIColor.orange.cgColor
    backgroundColor = .orange.withAlphaComponent(0.7)
  }
}

//
// SearchScene.swift
// 
//
// Created by ronael.bajazet on 07/01/2023.
// Copyright © 2023 RTEK SOLUTIONS. All rights reserved.
//

import UIKit

public final class SearchScene: NSObject {
  public class func make() -> UIViewController {
    let splitViewController = UISplitViewController()
    splitViewController.preferredDisplayMode = .oneBesideSecondary
    splitViewController.preferredPrimaryColumnWidthFraction = 0.4
    splitViewController.minimumPrimaryColumnWidth = splitViewController.view.bounds.size.width * 0.3
    splitViewController.maximumPrimaryColumnWidth = splitViewController.view.bounds.size.width
    splitViewController.view.backgroundColor = .systemBackground
    splitViewController.viewControllers = [AdsListFactory().makeView()]
    return splitViewController
  }
}

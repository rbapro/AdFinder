//
//  SceneDelegate.swift
//  AdFinder
//
//  Created by ronael.bajazet on 07/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = SearchScene.make()
    window.makeKeyAndVisible()
    self.window = window
  }
}

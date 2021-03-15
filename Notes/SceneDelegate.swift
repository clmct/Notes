//
//  SceneDelegate.swift
//  Notes
//
//  Created by Алмат Кульбаев on 13.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let assembly: AssemblyProtocol = Assembly()
    
    let window = UIWindow(windowScene: scene)
    window.rootViewController = assembly.createNotesListModule()
    window.makeKeyAndVisible()
    self.window = window
  }
}


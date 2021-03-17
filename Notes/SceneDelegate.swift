//
//  SceneDelegate.swift
//  Notes
//
//  Created by Алмат Кульбаев on 13.03.2021.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    

    
    
    
    let navigationController = UINavigationController()
    let assembly: AssemblyProtocol = Assembly(navigationController: navigationController)
    let router = MainRouter(assembly: assembly, navigationController: navigationController)
    let window = UIWindow(windowScene: scene)
    router.initialViewController()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
  }
}


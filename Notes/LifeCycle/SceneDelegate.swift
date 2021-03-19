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
    
    
    let rootAssembly: RootAssemblyProtocol = RootAssembly()
    let router = Router(presentationAssembly: rootAssembly.presentationAssembly)
    let window = UIWindow(windowScene: scene)
    window.rootViewController = router.navigationController
    window.makeKeyAndVisible()
    self.window = window
  }
}


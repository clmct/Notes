//
//  MainRouter.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

protocol RouterProtocol {
  func initialViewController()
  func showNoteEditor(identifire: String)
  var navigationController: UINavigationController { get }
}

final class Router: RouterProtocol {
  
  var navigationController = UINavigationController()
  
  private let presentationAssembly: PresentationAssemblyProtocol
  
  init(presentationAssembly: PresentationAssemblyProtocol) {
    self.presentationAssembly = presentationAssembly
    initialViewController()
  }
  
  func initialViewController() {
    let viewController = presentationAssembly.createNotesListModule(router: self)
    navigationController.viewControllers = [viewController]
  }
  
  func showNoteEditor(identifire: String) {
    let viewController = presentationAssembly.createNoteEditorModule(identifire: identifire)
    navigationController.pushViewController(viewController, animated: true)
  }
  
}

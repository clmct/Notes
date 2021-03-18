//
//  MainRouterProtocol.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

protocol MainRouterProtocol {
  func initialViewController()
  func showNoteEditor(identifire: String)
  func showAddNote()
}

final class MainRouter: MainRouterProtocol {
  
  var assembly: AssemblyProtocol
  var navigationController: UINavigationController
  
  init(assembly: AssemblyProtocol, navigationController: UINavigationController) {
    self.assembly = assembly
    self.navigationController = navigationController
  }
  
  func initialViewController() {
    let viewController = assembly.createNotesListModule(router: self)
    navigationController.viewControllers = [viewController]
  }
  
  func showNoteEditor(identifire: String) {
    let viewController = assembly.createNoteEditorModule(identifire: identifire)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showAddNote() {
    
  }
  
}

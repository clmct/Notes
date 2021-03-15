//
//  Assembly.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

protocol AssemblyProtocol {
  func createNotesListModule(router: MainRouterProtocol) -> UIViewController
  func createNoteEditorModule() -> UIViewController
}

final class Assembly: AssemblyProtocol {
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func createNotesListModule(router: MainRouterProtocol) -> UIViewController {
    let viewController = NotesListViewController()
    let presenter = NotesListPresenter(viewController: viewController, router: router)
    viewController.presenter = presenter
    return viewController
  }
  
  func createNoteEditorModule() -> UIViewController {
    let viewController = NoteEditorViewController()
    let presenter = NoteEditorPresenter(viewController: viewController)
    viewController.presenter = presenter
    return viewController
  }
}

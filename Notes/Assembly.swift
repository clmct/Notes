//
//  Assembly.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

protocol AssemblyProtocol {
  func createNotesListModule(router: MainRouterProtocol) -> UIViewController
  func createNoteEditorModule(identifire: String) -> UIViewController
}

final class Assembly: AssemblyProtocol {
  
  var navigationController: UINavigationController
  var coreDataManager = CoreDataManager()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func createNotesListModule(router: MainRouterProtocol) -> UIViewController {
    let viewController = NotesListViewController()
    let presenter = NotesListPresenter(viewController: viewController, router: router, coreData: coreDataManager)
    viewController.presenter = presenter
    return viewController
  }
  
  func createNoteEditorModule(identifire: String) -> UIViewController {
    let viewController = NoteEditorViewController()
    let presenter = NoteEditorPresenter(viewController: viewController, coreData: coreDataManager, identifire: identifire)
    viewController.presenter = presenter
    return viewController
  }
}

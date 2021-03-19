//
//  PresentationAssembly.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

protocol PresentationAssemblyProtocol {
  func createNotesListModule(router: RouterProtocol) -> UIViewController
  func createNoteEditorModule(identifire: String) -> UIViewController
}

final class PresentationAssembly: PresentationAssemblyProtocol {
  
  private let serviceAssembly: ServiceAssemblyProtocol
  
  init(serviceAssembly: ServiceAssemblyProtocol) {
    self.serviceAssembly = serviceAssembly
  }
  
  func createNotesListModule(router: RouterProtocol) -> UIViewController {
    let viewController = NotesListViewController()
    let presenter = NotesListPresenter(viewController: viewController,
                                       router: router,
                                       coreDataService: self.serviceAssembly.coreDataService)
    viewController.presenter = presenter
    return viewController
  }
  
  func createNoteEditorModule(identifire: String) -> UIViewController {
    let viewController = NoteEditorViewController()
    let presenter = NoteEditorPresenter(viewController: viewController,
                                        coreDataService: self.serviceAssembly.coreDataService,
                                        identifire: identifire)
    viewController.presenter = presenter
    return viewController
  }
}

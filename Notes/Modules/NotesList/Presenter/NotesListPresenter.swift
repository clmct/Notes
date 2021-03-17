//
//  NotesPresenter.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import Foundation

protocol NotesListPresenterProtocol {
  func showNoteEditor()
}

final class NotesListPresenter: NotesListPresenterProtocol {
  
  weak var viewController: NotesListViewController?
  var router: MainRouterProtocol
  var notes = [Note]()
  
  init(viewController: NotesListViewController, router: MainRouterProtocol) {
    self.viewController = viewController
    self.router = router
  }
  
  func showNoteEditor() {
    router.showNoteEditor()
  }
  
}

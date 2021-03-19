//
//  NotesPresenter.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import Foundation
import CoreData

protocol NotesListPresenterProtocol {
  func showNoteEditor(identifire: String)
  func showAddNote()
  func getContext() -> NSManagedObjectContext
}

final class NotesListPresenter: NotesListPresenterProtocol {
  
  weak var viewController: NotesListViewController?
  var router: RouterProtocol
  var coreDataService: CoreDataServiceProtocol
  
  init(viewController: NotesListViewController, router: RouterProtocol, coreDataService: CoreDataServiceProtocol) {
    self.viewController = viewController
    self.router = router
    self.coreDataService = coreDataService
  }
  
  func getContext() -> NSManagedObjectContext {
    return self.coreDataService.getContext()
  }
  
  func showAddNote() {
    let newId = UUID().uuidString
    router.showNoteEditor(identifire: newId)
  }
  
  func showNoteEditor(identifire: String) {
    router.showNoteEditor(identifire: identifire)
  }
  
}

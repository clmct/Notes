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
  func getContext() -> NSManagedObjectContext
}

final class NotesListPresenter: NotesListPresenterProtocol {
  
  weak var viewController: NotesListViewController?
  var router: MainRouterProtocol
  var notes = [Note]()
  var coreData: CoreDataManager
  
  init(viewController: NotesListViewController, router: MainRouterProtocol, coreData: CoreDataManager) {
    self.viewController = viewController
    self.router = router
    self.coreData = coreData
    
    let note = Note(text: "tu", identifire: UUID().uuidString, date: Date.init())
    let test = NoteModel(model: note, context: coreData.context)
    coreData.saveContext()
  }
  
  func getContext() -> NSManagedObjectContext {
    return coreData.context
  }
  
  func showNoteEditor(identifire: String) {
    router.showNoteEditor(identifire: identifire)
  }
  
}

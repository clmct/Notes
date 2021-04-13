//
//  NoteEditorPresenter.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import Foundation
import CoreData

protocol NoteEditorViewControllerDelegate: class {
  func setData(model: NoteModel)
}

protocol NoteEditorPresenterProtocol {
  func fetchData()
  func update(with text: String)
}

final class NoteEditorPresenter: NoteEditorPresenterProtocol {
  
  weak var viewController: NoteEditorViewControllerDelegate?
  var coreDataService: CoreDataServiceProtocol
  let identifire: String

  init(viewController: NoteEditorViewController, coreDataService: CoreDataServiceProtocol, identifire: String) {
    self.viewController = viewController
    self.coreDataService = coreDataService
    self.identifire = identifire
  }
  
  func fetchData() {
    self.coreDataService.fetchData(identifire: self.identifire) { (noteModel) in
      self.viewController?.setData(model: noteModel)
    }
  }
  
  func update(with text: String) {
    self.coreDataService.update(with: text, identifire: self.identifire)
  }
    
}

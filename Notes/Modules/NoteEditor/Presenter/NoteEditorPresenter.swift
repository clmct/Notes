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
  func addNote(with model: Note)
  func fetchData()
}

final class NoteEditorPresenter: NoteEditorPresenterProtocol {
  func fetchData() {
    
    
    let context = self.coreData.context
    let entityDescription = NSEntityDescription.entity(forEntityName: "NoteModel", in: context)

    let request = NSFetchRequest<NoteModel>(entityName: "NoteModel")
    let sort = NSSortDescriptor(key: "identifire", ascending: true)
    request.sortDescriptors = [sort]
    
    
    
    
    do {
      let note = try context.fetch(request)
      if let model = note.first {
        viewController?.setData(model: model)
      }
      
    } catch {
        fatalError("Failed to fetch employees: \(error)")
    }

    
      
    
  }
  
  func addNote(with model: Note) {
//    let note = NoteModel(model: model, context: coreData.context)
//    coreData.saveContext()
  }
  
  
  weak var viewController: NoteEditorViewControllerDelegate?
  var coreData: CoreDataManager
  let identifire: String
  
  init(viewController: NoteEditorViewController, coreData: CoreDataManager, identifire: String) {
    self.viewController = viewController
    self.coreData = coreData
    self.identifire = identifire
  }
  
}

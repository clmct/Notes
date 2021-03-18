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
    var coreData: CoreDataManager
    let identifire: String
    
    init(viewController: NoteEditorViewController, coreData: CoreDataManager, identifire: String) {
      self.viewController = viewController
      self.coreData = coreData
      self.identifire = identifire
    }
    
  func fetchData() {
    let context = self.coreData.context
    let request = NSFetchRequest<NoteModel>(entityName: "NoteModel")
    let predicate = NSPredicate(format: "identifire == %@", self.identifire)
    request.predicate = predicate
    do {
      let note = try context.fetch(request)
      if let model = note.first {
        viewController?.setData(model: model)
      }
    } catch let error {
      print(error)
    }
  }
  
  func update(with text: String) {
    let context = self.coreData.context
    let request = NSFetchRequest<NoteModel>(entityName: "NoteModel")
    let predicate = NSPredicate(format: "identifire == %@", self.identifire)
    request.predicate = predicate
    do {
      let notes = try context.fetch(request)
      let isNull = notes.count == 0
      switch isNull {
      case true:
        if text == "" {
          break
        }
        let model = Note(text: text, identifire: UUID().uuidString, date: Date.init())
        _ = NoteModel(model: model, context: coreData.context)
        coreData.saveContext()
      case false:
        guard let modelObject = notes.first else { return }
        if text == modelObject.text { return }
        modelObject.setValue(text, forKey: "text")
        modelObject.setValue(Date.init(), forKey: "date")
        if text == "" {
          context.delete(modelObject)
        }
      }
      coreData.saveContext()
    } catch let error {
      print(error)
    }
  }
}

//
//  CoreDataService.swift
//  Notes
//
//  Created by Almat Kulbaev on 19.03.2021.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
  func fetchData(identifire: String, completion: @escaping (NoteModel) -> Void )
  func update(with text: String, identifire: String)
  func getContext() -> NSManagedObjectContext
}

final class CoreDataService: CoreDataServiceProtocol {
  
  let coreDatasStack: CoreDatasStackProtocol
  
  init(coreDatasStack: CoreDatasStackProtocol) {
    self.coreDatasStack = coreDatasStack
    #if DEBUG
    setupNotes()
    #endif
  }
  
  func getContext() -> NSManagedObjectContext {
    return coreDatasStack.context
  }
  
  func fetchData(identifire: String, completion: @escaping (NoteModel) -> Void ) {
    let context = self.coreDatasStack.context
    let request = NSFetchRequest<NoteModel>(entityName: "NoteModel")
    let predicate = NSPredicate(format: "identifire == %@", identifire)
    request.predicate = predicate
    do {
      let note = try context.fetch(request)
      if let model = note.first {
        completion(model)
      }
    } catch let error {
      print(error)
    }
  }
  
  func update(with text: String, identifire: String) {
    let context = self.coreDatasStack.context
    let request = NSFetchRequest<NoteModel>(entityName: "NoteModel")
    let predicate = NSPredicate(format: "identifire == %@", identifire)
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
        _ = NoteModel(model: model, context: self.coreDatasStack.context)
        coreDatasStack.saveContext()
      case false:
        guard let modelObject = notes.first else { return }
        if text == modelObject.text { return }
        modelObject.setValue(text, forKey: "text")
        modelObject.setValue(Date.init(), forKey: "date")
        if text == "" {
          context.delete(modelObject)
        }
      }
      coreDatasStack.saveContext()
    } catch let error {
      print(error)
    }
  }
}

// MARK: Debug mode setup
extension CoreDataService {
  
  func isAppAlreadyLaunchedOnce()-> Bool {
    let defaults = UserDefaults.standard
    if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil {
      return true
    } else {
      defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
      return false
    }
  }
  
  func setupNotes() {
    if isAppAlreadyLaunchedOnce() == false {
      let model = Note(text: "Тестовая заметка", identifire: UUID().uuidString, date: Date.init())
      _ = NoteModel(model: model, context: self.coreDatasStack.context)
      coreDatasStack.saveContext()
    }
  }
  
}

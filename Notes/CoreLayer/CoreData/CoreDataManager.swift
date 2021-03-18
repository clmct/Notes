//
//  CoreDataStack.swift
//  Notes
//
//  Created by Алмат Кульбаев on 18.03.2021.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
  var context: NSManagedObjectContext { get set }
  func saveContext()
}

final class CoreDataManager: CoreDataManagerProtocol {
  
  init() {
    self.context.mergePolicy = NSOverwriteMergePolicy
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreDataModel")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error {
        fatalError("Could not load data store: \(error)")
      }
    }
    return container
  }()
  
  lazy var context: NSManagedObjectContext = persistentContainer.viewContext
  
  func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
              print(error)
            }
        }
    }
  
}

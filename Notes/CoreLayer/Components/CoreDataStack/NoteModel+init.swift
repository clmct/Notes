//
//  NoteModel+init.swift
//  Notes
//
//  Created by Алмат Кульбаев on 18.03.2021.
//

import Foundation
import CoreData

extension NoteModel {
  convenience init(model: Note, context: NSManagedObjectContext) {
    self.init(context: context)
    self.text = model.text
    self.date = model.date
    self.identifire = model.identifire
    
  }
}

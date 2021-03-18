//
//  NoteModel+CoreDataProperties.swift
//  Notes
//
//  Created by Алмат Кульбаев on 18.03.2021.
//
//

import Foundation
import CoreData

extension NoteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModel> {
        return NSFetchRequest<NoteModel>(entityName: "NoteModel")
    }

    @NSManaged public var date: Date?
    @NSManaged public var identifire: String?
    @NSManaged public var text: String?

}

extension NoteModel : Identifiable {

}

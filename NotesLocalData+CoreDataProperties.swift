//
//  NotesLocalData+CoreDataProperties.swift
//  ZOHO Notes
//
//
//

import Foundation
import CoreData


extension NotesLocalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesLocalData> {
        return NSFetchRequest<NotesLocalData>(entityName: "NotesLocalData")
    }

    @NSManaged public var note_body: String?
    @NSManaged public var note_id: String?
    @NSManaged public var note_image: Data?
    @NSManaged public var note_time: String?
    @NSManaged public var note_title: String?

}

extension NotesLocalData : Identifiable {

}

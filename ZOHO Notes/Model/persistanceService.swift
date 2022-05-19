//
//  persistanceService.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 18/05/22.
//

import Foundation
import CoreData


// MARK: - Core Data stack

class PersistanceService {
    
    var context: NSManagedObjectContext {return persistentContainer.viewContext}
    static var shared = PersistanceService()
    
 lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
    */
    let container = NSPersistentContainer(name: "ZOHO_Notes")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support

 func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
    
    func saveNotesData(note: Notes){
        let notes: NotesLocalData = NSEntityDescription.insertNewObject(forEntityName: "NotesLocalData", into: context) as! NotesLocalData
        notes.note_body = note.body
        notes.note_id = note.id
        notes.note_image = note.imgData 
        notes.note_title = note.title
        notes.note_time = note.time
        
        saveContext()
        
        
    }
    
    func getLocalSavedNotes() -> [Notes]{
        let request: NSFetchRequest<NotesLocalData> = NotesLocalData.fetchRequest()
        do{
            let notes = try context.fetch(request)
            
            var n = [Notes]()
            notes.forEach { note in
                n.append(Notes(id: note.note_id ?? "", title: note.note_title ?? "", body: note.note_body ?? "", time: note.note_time ?? "", image: nil, imgData: note.note_image))
            }
            
            return n
        }catch{
            return []
        }
    }
    
}


//
//  CoreDataController.swift
//  BeBrave
//
//  Created by Alaeldin Tirba on 2/20/20.
//  Copyright © 2020 Alaeldin Tirba. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BeBrave")
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
    
    private func getEntityBy(name: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        do {
            // Execute Fetch Request
            let entities = try persistentContainer.viewContext.fetch(fetchRequest)
            return entities as! [NSManagedObject]
        
        } catch {
            print("Unable to fetch managed objects for entity \(name).")
        }
        return nil
    }
    
    private func createNewEntity(entity: String) -> NSManagedObject? {
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: persistentContainer.viewContext)
        
        if let entityDescription = entityDescription {
            // Create Managed Object
            return NSManagedObject(entity: entityDescription, insertInto: persistentContainer.viewContext)
        }

        return nil
    }
    // MARK: - Core Data Saving support

    private func saveContext () {
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
}

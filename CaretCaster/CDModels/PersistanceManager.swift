//
//  PersistanceManager.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/1/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataError: Error {
  case fetchFailed
}

final class PersistanceManager {
  
  static let shared = PersistanceManager()
  
  private init() {}
  
  lazy var context = persistentContainer.viewContext

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CaretCaster")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func save() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
        print("saved successfully")
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func fetchAll<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    do {
      let fetchedObjects = try context.fetch(fetchRequest) as? [T]
      return fetchedObjects ?? [T]()
    } catch {
      print(CoreDataError.fetchFailed)
      return [T]()
    }
  }
  
}

//
//  NSManagedObjectContext.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/21.
//

import Foundation
import CoreData

protocol Managed {
    static var entityName: String { get }
}

extension Task: Managed {
    static var entityName: String {
        return "Task"
    }
}

extension Work: Managed {
    static var entityName: String {
        return "Work"
    }
}

extension NSManagedObjectContext {
    public func saveContext() {
        if hasChanges {
            do {
                try save()
            } catch {
                print(error)
            }
        }
    }
    
    public func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            self.saveContext()
        }
    }
    
    func createEntity<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
}

extension Task {
    static func create(with context: NSManagedObjectContext, name: String) -> Task {
        let task: Task = context.createEntity()
        task.name = name
        task.date = Date()
        task.updateDate = task.date
        return task
    }
    
//    static func fetchAll() -> [Task] {
//        let request = NSFetchRequest<Self>(entityName: entityName)
//        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(date), ascending: true)]
//        do {
//            let results = try FMCoreData.shared.backgroundContext.fetch(request)
//            return results
//        } catch {
//            fatalError("Failed to fetch task: \(error)")
//        }
//    }
}

extension Work {
    static func create(with context: NSManagedObjectContext, name: String) -> Work {
        let work: Work = context.createEntity()
        work.name = name
        work.date = Date()
        return work
    }

}

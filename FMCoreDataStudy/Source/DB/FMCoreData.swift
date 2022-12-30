//
//  FMCoreData.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import UIKit
import CoreData

class FMCoreData: NSObject {
    
    /// 单例
    static let shared = FMCoreData()
    
    /// 持久化容器
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unabel to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    /// 上下文
    lazy var backgroundContext = persistentContainer.newBackgroundContext()
    
    
    /// 添加
    func insert(task: Task) {
        backgroundContext.performChanges {
            self.backgroundContext.insert(task)
//            _ = Task.insert(into: self.backgroundContext, name: task.name ?? "")
        }
    }
    
    /// 删除
    func delete(task: Task) {
        backgroundContext.performChanges {
            self.backgroundContext.delete(task)
        }
//        guard let date = task.date else { return }
//        let request = NSFetchRequest<NSManagedObject>(entityName: "Task")
//        request.predicate = NSPredicate(format: "date == %@", date as CVarArg)
//        let entity = try? backgroundContext.fetch(request).first
//        if let entity = entity {
//            self.backgroundContext.delete(entity)
//        }
    }
    
    /// 查询
    func fetch() -> [Task] {
        let taskFetch = Task.sortedFetchRequest
        do {
            let tasks = try backgroundContext.fetch(taskFetch)
            
//            var results = [TaskModel]()
//            for entity in tasks {
//                let model = TaskModel()
//                model.name = entity.name
//                model.date = entity.date
//                results.append(model)
//            }
            
            return tasks
        } catch {
            fatalError("Failed to fetch task: \(error)")
        }
    }
}

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
    
    /// 创建
    func create(name: String) -> Task {
        return NSEntityDescription.insertNewObject(forEntityName: name, into: backgroundContext) as! Task
    }
    
    // 添加
    func save() {
        do {
            try backgroundContext.save()
        } catch {
            print(error)
        }
    }
    
    /// 添加
    func insert(task: TaskModel) {
        let entity = create(name: "Task")
        entity.name = task.name
        entity.date = task.date
        
        backgroundContext.insert(entity)
    }
    
    /// 查询
    func fetch() -> [TaskModel] {
        let taskFetch = NSFetchRequest<NSManagedObject>(entityName: "Task")
        do {
            let tasks = try backgroundContext.fetch(taskFetch) as! [Task]
            
            var results = [TaskModel]()
            for entity in tasks {
                let model = TaskModel()
                model.name = entity.name
                model.date = entity.date
                results.append(model)
            }
            
            return results
        } catch {
            fatalError("Failed to fetch task: \(error)")
        }
    }
    
    /// 删除
    func delete(task: TaskModel) {
        guard let date = task.date else { return }
        let request = NSFetchRequest<NSManagedObject>(entityName: "Task")
        request.predicate = NSPredicate(format: "date == %@", date as CVarArg)
        let entity = try? backgroundContext.fetch(request).first
        if let entity = entity {
            self.backgroundContext.delete(entity)
        }
    }
}

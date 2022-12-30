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
    func insert(entity: NSManagedObject) {
        backgroundContext.performChanges {
            self.backgroundContext.insert(entity)
        }
    }
    
    /// 删除
    func delete(entity: NSManagedObject) {
        backgroundContext.performChanges {
            self.backgroundContext.delete(entity)
        }
    }
    
    // 更新
    func update(entity: NSManagedObject) {
        backgroundContext.performChanges {
            self.backgroundContext.refresh(entity, mergeChanges: true)
        }
    }
    
    /// 查询
    func fetch(name: String) -> [NSManagedObject] {
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: name)
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            
            let tasks = try backgroundContext.fetch(request)
            return tasks
        } catch {
            fatalError("Failed to fetch task: \(error)")
        }
    }
}

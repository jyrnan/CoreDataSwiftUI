//
//  NSManagedObjectContext++.swift
//  NSManagedObjectContext++
//
//  Created by Yong Jin on 2021/8/14.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {fatalError("Wrong object type")}
        return obj
    }
}

extension NSManagedObjectContext {
    public func saveOrRollback() -> Bool {
        do{
            try self.save()
            return true
        } catch {
            rollback()
            print(#function, "RollBack")
            return false
        }
    }
    
    public func performChanges(block: @escaping () -> Void) {
        perform{
            block()
            _ = self.saveOrRollback()
        }
    }
    
}


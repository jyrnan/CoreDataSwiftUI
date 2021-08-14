//
//  Item+Managed.swift
//  Item+Managed
//
//  Created by Yong Jin on 2021/8/14.
//

import Foundation
import CoreData

extension Item: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(timestamp), ascending: true)]
    }
}

extension Item {
    static func insert(into context: NSManagedObjectContext) -> Item {
        let item: Item = context.insertObject()
        item.timestamp = Date()
        return item
    }
}

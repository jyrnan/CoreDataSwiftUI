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
        return [NSSortDescriptor(key: #keyPath(timestamp), ascending: false)]
    }
}

func test() {
    let request = Item.sortedFetchRequest
    
}

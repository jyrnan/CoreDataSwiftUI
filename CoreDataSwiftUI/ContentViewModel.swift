//
//  ContentViewModel.swift
//  ContentViewModel
//
//  Created by Yong Jin on 2021/8/14.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class ContentViewModel<A: NSManagedObject & Managed>: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    @Published private(set) var items: [A] = []
    
    var fetchedRequestController: NSFetchedResultsController<A>
    let context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
        self.fetchedRequestController = NSFetchedResultsController(fetchRequest: A.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchedRequestController.delegate = self
        refresh()
    }
    
    func refresh() {
        try! fetchedRequestController.performFetch()
        if let result = fetchedRequestController.fetchedObjects {
            items = result}
    }
    
    func addItem() {
        context.performChanges {
            _ = Item.insert(into: self.context)
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        context.performChanges {
            offsets.map{self.items[$0]}.forEach(self.context.delete(_:))
        }
    }
    //MARK: - Delegate Method
    //FRC能够自动监测viewContext数据的变化？！
    //所以一旦数据发生变化，就调用代理代理方法。一共用3个，实现这个是最基本的
    //通过代理方法对重新赋值
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let result = fetchedRequestController.fetchedObjects {
            items = result
        }
    }
}

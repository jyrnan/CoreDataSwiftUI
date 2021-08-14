//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Yong Jin on 2021/8/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    @ObservedObject private(set) var viewModel: ContentViewModel<Item>
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(items) { item in
//                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                }
//                .onDelete(perform: deleteItems)
//
//                Divider()
                
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: DetailView(item: item)){
                        Text("Item at \(item.timestamp!, formatter: itemFormatter), count: \(item.count)")}
                }
                .onDelete(perform: viewModel.deleteItems(offsets:))
            }
            .toolbar {
                HStack {
                #if os(iOS)
                    EditButton()
                #endif
                    
                    Button(action: viewModel.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    Button(action: viewModel.refresh) {
                        Label("Refresh", systemImage: "cross")
                    }
                }
                
                   
               
            }
            .navigationTitle("CoreData")
        }
    }
    
    
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { viewModel.items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(context: PersistenceController.preview.container.viewContext)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

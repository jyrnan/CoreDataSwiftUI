//
//  CoreDataSwiftUIApp.swift
//  CoreDataSwiftUI
//
//  Created by Yong Jin on 2021/8/14.
//

import SwiftUI

@main
struct CoreDataSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

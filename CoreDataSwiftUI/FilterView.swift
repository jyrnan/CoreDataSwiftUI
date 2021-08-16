//
//  FilterView.swift
//  FilterView
//
//  Created by Yong Jin on 2021/8/15.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
            animation: .default)
        private var items: FetchedResults<Item>
    @State var itemsFilterd:[Item] = []
    var body: some View {
        List{
            ForEach(itemsFilterd) {item in
                Text("Item at \(item.timestamp!.formatted()), count: \(item.count)")
            }
        }
        .onReceive(items.publisher, perform: {_ in
            itemsFilterd = items.filter{$0.count != 0}
        })
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

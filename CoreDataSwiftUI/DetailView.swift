//
//  Detail.swift
//  Detail
//
//  Created by Yong Jin on 2021/8/14.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var item: Item
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Item at \(item.timestamp ?? Date())")
            Text("Count: \(item.count)")
            Button(action: {
                item.count += 1
            }, label: {Text("update")})
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: PersistenceController.preview.container.viewContext.insertObject())
    }
}

//
//  ContentViewB.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

struct ContentViewB: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    
    private var items: FetchedResults<Item>

    var body: some View {
//        NavigationView {
        List {
            ForEach(items, id: \.self) { item in
                let _ = rowInitCountB += 1
                Text("B")
                let _ = print("ContentViewB item body evaluated: \(rowInitCountB)")
                // RowView(item: item)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

 var rowInitCountB = 0

private struct RowView: View {
    let item: Item
    
    var body: some View {
        
//        NavigationLink {
            Text("B") //\(item.title ?? "Title") at \(item.timestamp!, formatter: itemFormatter)")
//        } label: {
//            Text("Item \(item.title ?? "Title")")
//        }

        let _ = print("ContentViewB row body evaluated")
    }
}

#Preview {
    ContentViewB().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

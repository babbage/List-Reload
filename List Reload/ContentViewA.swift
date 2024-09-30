//
//  ContentViewA.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

/// With the ForEach called with a subview RowView for each item, the RowView body init method will be called
/// 6,500 times, once for each item in the Core Data store, even though only around 17 rows will initially be displayed.
struct ContentViewA: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id:\.self) { item in
                    RowView(item: item)
                }
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

private struct RowView: View {
    static var rowInitCount = 0

    let item: Item
    
    var body: some View {
        let _ = RowView.rowInitCount += 1
        
        NavigationLink {
            Text("\(item.title ?? "Title") at \(item.timestamp!, formatter: itemFormatter)")
        } label: {
            Text("Item \(item.title ?? "Title")")
        }

        let _ = print("ContentViewA row body evaluated: \(RowView.rowInitCount)")
    }
}

#Preview {
    ContentViewA().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

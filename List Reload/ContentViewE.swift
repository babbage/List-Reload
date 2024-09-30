//
//  ContentViewE.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

/// With RowView Equatable and specifying .equatable() within the ForEach, the correct lazy loading
/// behaviour of the ForEach is still observed with a more complex view that is within a NavigationView:
/// only 18 row bodies are evaluated on initial launch, just the views that are initially dispalyed on the screen.
struct ContentViewE: View {
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
                        .equatable()
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

private struct RowView: View, Equatable {
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

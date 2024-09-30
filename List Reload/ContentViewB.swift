//
//  ContentViewB.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

/// Simplifying the RowView content, and removing the NavigationView and NavigationLink does not change anything,
/// the RowView body is still called 6,500 times, once for each item in the Core Data store.
struct ContentViewB: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items, id:\.self) { item in
                RowView()
            }
        }
    }
}

private struct RowView: View {
    static var rowInitCount = 0

    var body: some View {
        let _ = RowView.rowInitCount += 1
        Text("B")
        let _ = print("ContentViewB row body evaluated: \(RowView.rowInitCount)")
    }
}

#Preview {
    ContentViewA().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

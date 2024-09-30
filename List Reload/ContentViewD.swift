//
//  ContentViewD.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

/// Making RowView Equatable and specifying .equatable() within the ForEach enables the use of a subview
/// while still getting the correct lazy loading behaviour of the ForEach: only 18 row bodies are evaluated on
/// initial launch, just the views that are initially dispalyed on the screen.
struct ContentViewD: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                RowView(title: "Item \(item.title ?? "Title")")
                    .equatable()
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

    let title: String
    
    var body: some View {
        let _ = RowView.rowInitCount += 1
        Text(title)
        let _ = print("ContentViewD row body evaluated: \(RowView.rowInitCount)")
    }
}

#Preview {
    ContentViewA().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

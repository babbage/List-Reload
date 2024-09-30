//
//  ContentViewD.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

/// Making RowView Equatable and specifying .equatable() within the ForEach enables the
/// use of a subview while still getting the lazy loading behaviour of the ForEach.
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

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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

#Preview {
    ContentViewA().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

var rowInitCountD = 0

private struct RowView: View, Equatable {
    let title: String
    
    var body: some View {
        let _ = rowInitCountD += 1
        
        Text(title)

        let _ = print("ContentViewD row body evaluated: \(rowInitCountD)")
    }
}

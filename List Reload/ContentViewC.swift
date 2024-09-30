//
//  ContentViewC.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

struct ContentViewC: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.objectID) { item in
                    let _ = rowInitCountC += 1
                    
                    NavigationLink {
                        Text("\(item.title ?? "Title") at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text("Item \(item.title ?? "Title")")
                    }

                    let _ = print("ContentViewC row body evaluated: \(rowInitCountC)")
                }
            }
        }
    }
}

var rowInitCountC = 0

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentViewC().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

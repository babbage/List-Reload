//
//  ContentViewC.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI
import CoreData

/// Moving the full contents of the origincal RowView to be directly inside the ForEach reduces the nuumber of times
/// the body is rendered to around 38 times, when 17 rows are being displayed. As with all other ifndings, seen on both
/// iPhone 15 Pro Max on iOS 18 plus iPhone 16 Pro simulator on iOS 18.1.
struct ContentViewC: View {
    static var rowInitCount = 0

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    let _ = ContentViewC.rowInitCount += 1
                    
                    NavigationLink {
                        Text("\(item.title ?? "Title") at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text("Item \(item.title ?? "Title")")
                    }

                    let _ = print("ContentViewC row body evaluated: \(ContentViewC.rowInitCount)")
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

#Preview {
    ContentViewC().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

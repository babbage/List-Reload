//
//  List_ReloadApp.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//

import SwiftUI

@main
struct List_ReloadApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    init() {
        DataGenerator.setupIfRequired()
    }    
}

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
            // Set the ContentView variant here to test alternate scenarios
            ContentViewA()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    init() {
        DataGenerator.setupIfRequired()
    }    
}

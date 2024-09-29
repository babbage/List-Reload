//
//  DataGenerator.swift
//  List Reload
//
//  Created by Duncan Babbage on 30/09/2024.
//
import UIKit

struct DataGenerator {
    static let dataGeneratedKey = "dataGenerated"
    
    static func setupIfRequired() {
        if dataNotGenerated() {
            generateData(6500)
            markDataGenerated()
        }
    }
    
    static func generateData(_ number: Int) {
        let context = PersistenceController.shared.container.viewContext

        for count in 0..<number {
            let newItem = Item(context: context)
            newItem.timestamp = Date()
            newItem.title = String(count)
        }
        
        try? context.save()
        print("\(number) generated")
    }
    
    private static func dataNotGenerated() -> Bool {
        let dataGenerated = UserDefaults.standard.bool(forKey: dataGeneratedKey)
        return !dataGenerated
    }
    
    private static func markDataGenerated() {
        UserDefaults.standard.set(true, forKey: dataGeneratedKey)
    }
}

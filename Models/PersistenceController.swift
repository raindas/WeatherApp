//
//  PersistenceController.swift
//  WeatherApp
//
//  Created by President Raindas on 20/07/2021.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "SavedCities")
        
        container.loadPersistentStores{
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

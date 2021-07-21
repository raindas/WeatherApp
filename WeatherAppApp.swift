//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by President Raindas on 19/07/2021.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(weatherVM)
        }
    }
}

//
//  SpeedTestApp.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import SwiftUI

@main
struct SpeedTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

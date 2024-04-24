//
//  Persistence.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Settings")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveSettings(isDarkMode: Bool, showCurrentSpeed: Bool, showTotalSpeed: Bool, url: String) {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<Settings> = Settings.fetchRequest()

        do {
            let results = try context.fetch(fetchRequest)
            let settings = results.first ?? Settings(context: context)
            settings.isDarkMode = isDarkMode
            settings.showCurrentSpeed = showCurrentSpeed
            settings.showTotalSpeed = showTotalSpeed
            settings.urlString = url
            try context.save()
        } catch {
            print("Failed to save settings: \(error)")
        }
    }

    func loadSettings() -> Settings? {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<Settings> = Settings.fetchRequest()
        do {
            let settings = try context.fetch(fetchRequest)
            return settings.first
        } catch {
            print("Failed to fetch settings: \(error)")
            return nil
        }
    }
}

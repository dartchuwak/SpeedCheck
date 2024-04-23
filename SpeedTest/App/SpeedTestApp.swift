//
//  SpeedTestApp.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import SwiftUI

@main
struct SpeedTestApp: App {
    let persistenceController = CoreDataStack.shared
    @StateObject var settingsViewModel: SettingsViewModel
    @StateObject var mainViewModel: MainViewModel

    init() {
        let settingsData = SettingsData()
        let speedTestService = SpeedTestService()
        self._settingsViewModel = StateObject(wrappedValue: SettingsViewModel(settingsData: settingsData))
        self._mainViewModel = StateObject(wrappedValue: MainViewModel(settingsData: settingsData, speedTest: speedTestService))
    }
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.colorScheme, settingsViewModel.currentScheme == .light ? .light : .dark)
                .environment(\.managedObjectContext, persistenceController.context)
                .environmentObject(settingsViewModel)
                .environmentObject(mainViewModel)
                .environment(\.speedTestService, SpeedTestService())
        }
    }
}

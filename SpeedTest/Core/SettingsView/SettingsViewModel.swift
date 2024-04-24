//
//  SettingsViewModel.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import Foundation
import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    @Environment(\.speedTestService) var speedTest
    @Published var isDarkMode: Bool = false
    var currentScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
    @Published var showCurrentSpeed = true
    @Published var showTotalSpeed = true
    @Published var URLString = ""
    @Published var currentSpeed = 0
    @Published var finalSpeed = 0
    @Published var bytesDownloaded = 0

    init() {
        guard let settings = CoreDataStack.shared.loadSettings() else { return } // Загрузка из CoreData
        // Установка значения
        self.isDarkMode = settings.isDarkMode
        self.showTotalSpeed = settings.showTotalSpeed
        self.showCurrentSpeed = settings.showCurrentSpeed
        self.URLString = settings.urlString ?? Endpoints.size512
    }

    func saveSettings() {
        CoreDataStack.shared.saveSettings(isDarkMode: isDarkMode, showCurrentSpeed: showCurrentSpeed, showTotalSpeed: showTotalSpeed, url: URLString)
    }

    func resetURL() {
        URLString = Endpoints.size512
    }
}

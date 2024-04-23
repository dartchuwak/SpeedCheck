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
    let settingsData: SettingsData
    @Environment(\.speedTestService) var speedTest
    @Published var isDarkMode: Bool = false
    var currentScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
    @Published var showCurrentSpeed = true
    @Published var showTotalSpeed = true
    @Published var URLString = "" {
        didSet {
            settingsData.url = URLString
        }
    }
    @Published var currentSpeed = 0
    @Published var finalSpeed = 0
    @Published var bytesDownloaded = 0

    init(settingsData: SettingsData) {
        self.settingsData = settingsData
        guard let settings = CoreDataStack.shared.loadSettings() else { return }
        self.settingsData.url = settings.urlString ?? "http://ipv4.download.thinkbroadband.com/512MB.zip"
        self.settingsData.isDarkMode = settings.isDarkMode
        self.settingsData.showTotalSpeed = settings.showTotalSpeed
        self.settingsData.showCurrentSpeed = settings.showCurrentSpeed

        self.isDarkMode = settings.isDarkMode
        self.showTotalSpeed = settings.showTotalSpeed
        self.showCurrentSpeed = settings.showCurrentSpeed
        self.URLString = settings.urlString ?? "http://ipv4.download.thinkbroadband.com/512MB.zip"
    }

    func saveSettings() {
        CoreDataStack.shared.saveSettings(isDarkMode: isDarkMode, showCurrentSpeed: showCurrentSpeed, showTotalSpeed: showTotalSpeed, url: URLString)
    }

    func resetURL() {
        URLString = "http://ipv4.download.thinkbroadband.com/512MB.zip"
    }
}

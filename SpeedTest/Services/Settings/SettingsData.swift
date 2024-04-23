//
//  SettingsData.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 24.04.2024.
//

import Foundation
import Combine

final class SettingsData {
    @Published var isDarkMode: Bool = false
    @Published var showCurrentSpeed = true
    @Published var showTotalSpeed = true
    @Published var url: String = "http://example.com"
}

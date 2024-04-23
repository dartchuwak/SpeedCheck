//
//  MainViewModel.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 24.04.2024.
//

import Foundation
import Combine
import SwiftUI

final class MainViewModel: ObservableObject {
    let settingsData: SettingsData
    let speedTest: SpeedTestService?
    @Published var currentSpeed: Double = 0.0
    @Published var finalSpeed: Double = 0.0
    @Published var bytesDownloaded = 0
    private var cancellables = Set<AnyCancellable>()


    init(settingsData: SettingsData, speedTest: SpeedTestService) {
        self.speedTest = speedTest
        self.settingsData = settingsData
        setSubscribtions()
    }

    func startTest() {
        speedTest?.startTest(url: settingsData.url)
    }

    func stopTest() {
        speedTest?.stop()
    }

    private func setSubscribtions() {
        speedTest?.$currentSpeed
            .receive(on: RunLoop.main)
            .sink { [weak self] speed in
                self?.currentSpeed = speed
            }
            .store(in: &cancellables)
        speedTest?.$finalSpeed
            .receive(on: RunLoop.main)
            .sink { [weak self] speed in
                self?.finalSpeed = speed
            }
            .store(in: &cancellables)
        speedTest?.$bytesDownloaded
            .receive(on: RunLoop.main)
            .sink { [weak self] speed in
                self?.bytesDownloaded = speed
            }
            .store(in: &cancellables)
    }
}

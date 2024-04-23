//
//  SpeedTestService.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import Foundation
import Alamofire
import Combine

final class SpeedTestService {
    // private properties
    private var startTime: Date?
    private var endTime: Date?
    private var lastBytesReceived: Int = 0
    private var lastUpdateTime: Date?
    private var request: DataRequest?
    // publised properties
    @Published var bytesDownloaded: Int = 0
    @Published var currentSpeed: Double = 0.0
    @Published var finalSpeed: Double = 0.0

    func startTest(url: String) {
        guard let url = URL(string: url) else { return }
        self.bytesDownloaded = 0
        self.finalSpeed = 0.0
        self.currentSpeed = 0.0
        self.lastBytesReceived = 0
        startTime = Date() // Засекаем время начала загрузки
        request = AF.request(url, method: .get)
            .downloadProgress { progress in
                // Отслеживаем прогресс загрузки и рассчитываем скорость в реальном времени
                self.update(bytesReceived: Int(progress.completedUnitCount))
            }
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.bytesDownloaded = data.count
                    self.endTime = Date() // Засекаем время окончания загрузки
                    let speed = self.calculateFinalSpeed()
                    self.finalSpeed = Double(speed)
                    print("Final download speed: \(speed) Mbps")
                case .failure(let error):
                    print("Download error: \(error.localizedDescription)")
                }
            }
    }

    func stop() {
        request?.cancel()  // Отменяем активный запрос
              endTime = Date()  // Фиксируем время остановки
              if let start = startTime, let end = endTime {
                  let duration = end.timeIntervalSince(start)
                  if duration > 0 {
                      let speed = Double(bytesDownloaded) / duration / 1024 / 1024 * 8 // Скорость в Mbps
                      finalSpeed = Double(speed)
                  }
              }
    }

    private func calculateFinalSpeed() -> Double {
        guard let start = startTime, let end = endTime else { return 0.0 }
        let duration = end.timeIntervalSince(start)
        let speed = Double(bytesDownloaded) / duration / 1024 / 1024 * 8 // Скорость в Mbps
        return speed
    }

    private func update(bytesReceived: Int) {
        let currentTime = Date()
        if let lastUpdateTime = lastUpdateTime {
            let timeInterval = currentTime.timeIntervalSince(lastUpdateTime)
            if timeInterval >= 0.1 { // Обновляем скорость не чаще чем каждые 0.1 секунды
                let bytesDiff = bytesReceived - lastBytesReceived
                currentSpeed = Double(Double(bytesDiff) / timeInterval / 1024 / 1024 * 8) // Скорость в Mbps
                bytesDownloaded = bytesReceived
                print("Current speed: \(currentSpeed) Mbps")
                // Обновляем последние значения
                lastBytesReceived = bytesReceived
                self.lastUpdateTime = currentTime
            }
        } else {
            // Инициализация при первом вызове
            lastUpdateTime = currentTime
            lastBytesReceived = bytesReceived
        }
    }
}

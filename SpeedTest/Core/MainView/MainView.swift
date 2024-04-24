//
//  MainView.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import SwiftUI

struct MainView: View {
    private let width = UIScreen.main.bounds.width - 30
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @State private var isRunning = false
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 32) {

                Gauge(value: mainViewModel.currentSpeed, in: 0...200) {
                         Image(systemName: "gauge.medium")
                             .font(.system(size: 50.0))
                     } currentValueLabel: {
                         Text(String(format: "%.0f", mainViewModel.currentSpeed))

                     }
                     .gaugeStyle(SpeedometerGaugeStyle())

                Button(action: {
                    if mainViewModel.isRunning {
                        mainViewModel.stopTest()
                        isRunning.toggle()
                    } else {
                        mainViewModel.startTest()
                        isRunning.toggle()
                    }
                }, label: {
                    Text(!mainViewModel.isRunning ? "Test Speed": "Stop")
                        .frame(width: width, height: 44)
                        .background(.yellow)
                        .cornerRadius(15)
                })
                ScrollView(.horizontal) {
                    Text("Target URL: \(mainViewModel.settingsData.url)")
                        .lineLimit(1)
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden, axes: .horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Recived bytes: \(mainViewModel.bytesDownloaded) bytes")
                    if settingsViewModel.showCurrentSpeed {
                        HStack {

                            Text("Current speed: \(String(format: "%.0f", mainViewModel.currentSpeed)) Mbps")
                            Spacer()
                        }
                    }

                    if settingsViewModel.showTotalSpeed {
                        HStack {

                            Text("Final speed: \(String(format: "%.0f", mainViewModel.finalSpeed)) Mbps")
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SpeedometerGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(.systemGray6))

            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(purpleGradient, lineWidth: 20)
                .rotationEffect(.degrees(135))

            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .round, dash: [1, 34], dashPhase: 0.0))
                .rotationEffect(.degrees(135))

            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text("Mbps")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.gray)
            }

        }
        .frame(width: 300, height: 300)

    }

}

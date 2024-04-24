//
//  SettingsView.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            VStack {
                Toggle(isOn: $settings.isDarkMode, label: {
                    Text("Use Dark Color Scheme")
                })

                TextField("", text: $settings.URLString, prompt: Text(verbatim: "http://ipv4.download.thinkbroadband.com/512MB.zip"))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                    }

                Button(action: {
                    settings.resetURL()
                }, label: {
                    Text("Reset to default URL")
                })

                Toggle("Test current speed", isOn: $settings.showCurrentSpeed)
                Toggle("Test final speed", isOn: $settings.showTotalSpeed)
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    settings.saveSettings()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}

//
//  ContentView.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 23.04.2024.
//

import SwiftUI
import CoreData

struct TabBarView: View {

    var body: some View {
        TabView {
            MainView()
                .tabItem { Label("Speed test", systemImage: "network") }
            NavigationView { // NavView for Toolbar
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}



#Preview {
    TabBarView()
}

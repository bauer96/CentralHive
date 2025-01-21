//
//  ContentView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Departments", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Employees", systemImage: "person.fill") {
                EmployeeView()
            }
            Tab("Hardware", systemImage: "desktopcomputer") {
                HardwareView()
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}

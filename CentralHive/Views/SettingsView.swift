//
//  SettingsView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI


struct SettingsView: View {
    @State private var darkMode = false
    @State private var notificationsEnabled = true
    @State private var isShowingAboutView = false
    
    // App version (you can update this dynamically if needed)
    let appVersion = "1.0.0 Beta"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkMode)
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }
                
                Section(header: Text("App Info")) {
                    Text("App Version: \(appVersion)")
                    
                    Button("About") {
                        isShowingAboutView.toggle()
                    }
                }
                
                Section {
                    Button("Log Out") {
                        // Logout Logik here later..
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $isShowingAboutView) {
                Text("About This App Section is actually in Development")
            }
            .presentationDetents([.medium])
        }
    }
}


#Preview {
    SettingsView()
}

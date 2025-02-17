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
    
    
    let appVersion = "1.0.0 Beta"

    var body: some View {
        NavigationView {
            VStack {
                // Image at the top, centered
                Image("myImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 20)
                
                Text("Hannes Bauer")
                    .font(.footnote)
                Text("user.name@company.de")
                    .textContentType(.emailAddress)
                    .font(.footnote)
                    .foregroundStyle(.iconForeground)

             
                Form {
//                    Section(header: Text("Appearance")) {
//                        Toggle("Dark Mode", isOn: $darkMode)
//                    }
                    
                    Section(header: Text("Notifications")) {
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    }
                    
                    Section(header: Text("App Info")) {
                        Button("About") {
                            isShowingAboutView.toggle()
                        }
                    }
                    
                    Section {
                        Button("Log Out") {
                            // Logout logic here later...
                        }
                        .foregroundColor(.red)
                    }
                }
                
                // App Version Below Form
                Text("Version \(appVersion)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                    .padding(.bottom, 20)
                
            }
            .scrollDisabled(true)
            .navigationTitle("Settings")
            .sheet(isPresented: $isShowingAboutView) {
                AboutView()
                .presentationDetents([.medium])
            }
        }
    }
}



#Preview {
    SettingsView()
}

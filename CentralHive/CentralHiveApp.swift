//
//  CentralHiveApp.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI
import SwiftData

@main
struct CentralHiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Department.self, Employee.self, Hardware.self])
    }
}

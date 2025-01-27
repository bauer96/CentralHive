//
//  ContentView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            Tab("Departments", systemImage: "house.fill") {
                DepartmentListView()
            }
            Tab("Employees", systemImage: "person.fill") {
                EmployeeListView()
            }
            Tab("Hardware", systemImage: "desktopcomputer") {
                HardwareListView()
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }
    }
}
//
//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Department.self, configurations: config)
//        
//        let exampleDepartment = Department(id: UUID(), name: "IT", employees: [])
//        return ContentView()
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to Create Model Container")
//    }
//}

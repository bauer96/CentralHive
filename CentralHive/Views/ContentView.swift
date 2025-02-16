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
    
    private let selectedTabColor = Color.iconForeground
    
    var body: some View {
        TabView {
            Tab("Departments", systemImage: "house.fill") {
                DepartmentListView()
                    .preferredColorScheme(.dark)
            }
            Tab("Employees", systemImage: "person.fill") {
                EmployeeListView()
                    .preferredColorScheme(.dark)
            }
            Tab("Hardware", systemImage: "desktopcomputer") {
                HardwareListView()
                    .preferredColorScheme(.dark)
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
                    .preferredColorScheme(.dark)
            }
        }
        .tint(selectedTabColor)
        .accentColor(selectedTabColor)
        .onAppear {
                   // Customize TabBar appearance
                   let appearance = UITabBarAppearance()
                   appearance.backgroundColor = .background// Or any UIColor
                   UITabBar.appearance().standardAppearance = appearance
                   UITabBar.appearance().scrollEdgeAppearance = appearance
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

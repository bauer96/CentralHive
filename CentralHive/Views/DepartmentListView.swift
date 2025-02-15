//
//  HomeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI
import SwiftData

struct DepartmentListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var departments: [Department]
    @State private var isAddingDepartment = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if departments.isEmpty {
                    EmptyDepartmentView()
                } else {
                    DepartmentGrid()
                }
            }
            .navigationTitle("Departments")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddingDepartment.toggle()
                    }) {
                        Image(systemName: "rectangle.stack.fill.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingDepartment) {
                AddDepartmentView()
                    .presentationDetents([.large])
            }
        }
    }
    
    func deleteDepartments(_ indexSet: IndexSet) {
        for index in indexSet {
            let department = departments[index]
            modelContext.delete(department)
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Department.self, configurations: config)
        
        let exampleDepartment = Department(id: UUID(), name: "IT", employees: [])
        return   DepartmentListView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to Create Model Container")
    }
  
}



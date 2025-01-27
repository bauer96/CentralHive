//
//  DepartmentDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//

import SwiftUI
import SwiftData

struct DepartmentDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var department: Department
    @Query private var employees: [Employee]
    @State private var isAddingEmployee = false

    
    var body: some View {
        NavigationStack {
            VStack {
//                Text(department.name)
//                    .font(.largeTitle)
//                    .padding()
                
                Text("Number of Employees: \(department.employees.count)")
                    .font(.headline)
                    .padding(.bottom)
                
                List {
                    Section("Employees") {
                        ForEach(department.employees) { employee in
                            NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        Text(employee.name)
                                            .font(.headline)
                                        Text(employee.position)
                                            .font(.subheadline).foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteEmployees)
                    }
                }
        }
        }
        .navigationTitle(department.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isAddingEmployee.toggle()
                }) {
                    Image(systemName: "plus")
                }
                    
                
            }
        }
        .sheet(isPresented: $isAddingEmployee) {
             AddEmployeeView()
                .presentationDetents([.medium])
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    func deleteEmployees(_ indexSet: IndexSet) {
        for index in indexSet {
            let employee = employees[index]
            modelContext.delete(employee)
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: [Employee.self,Department.self], configurations: config)
//        
//        let exampleDepartment = Department(id: UUID(), name: "IT", employees: [])
//        return DepartmentDetailView()
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to Create Model Container")
//    }
//}

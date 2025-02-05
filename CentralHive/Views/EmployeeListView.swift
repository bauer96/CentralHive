//
//  EmployeeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI
import SwiftData


struct EmployeeListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isAddingEmployee = false
    @Query var employees: [Employee]
    @State private var path = [Employee]()
    
    var body: some View {
        NavigationStack(path: $path) {
           
            List {
                ForEach(employees) { employee in
                NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                    Text(employee.firstName)
                    Text(employee.lastName)
                }
                }
                .onDelete(perform: deleteEmployees)
                }
            .navigationTitle("Employees")
            .navigationDestination(for: Employee.self, destination: EmployeeDetailView.init)
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
            }
        }
    func deleteEmployees(_ indexSet: IndexSet) {
        for index in indexSet {
            let employee = employees[index]
            modelContext.delete(employee)
        }
    }
    }

#Preview {
    EmployeeListView()
}

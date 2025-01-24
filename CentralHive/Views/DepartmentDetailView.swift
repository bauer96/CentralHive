//
//  DepartmentDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//

import SwiftUI
import SwiftData

struct DepartmentDetailView: View {
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
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DepartmentDetailView()
//}

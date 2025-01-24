//
//  HomeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI
import SwiftData

struct DepartmentListView: View {
    @Query var departments: [Department]
    @State private var isAddingDepartment = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if departments.isEmpty {
                    VStack {
                        Text("Welcome to CentralHive")
                            .font(.headline)
                            .padding()
                        Text("Manage Employees and Hardware")
                            .font(.subheadline)
                            .padding()
                    }
                } else {
                    List(departments) { department in
                        NavigationLink(destination: DepartmentDetailView(department: department)) {
                            Text(department.name)
                            Text("\(department.employees.count)")
                            Image(systemName: "person.3.fill")
                        }
                    }
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
            }
        }
    }
}

#Preview {
    DepartmentListView()
}



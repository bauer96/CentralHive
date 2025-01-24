//
//  AddEmployeeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//

import SwiftUI
import SwiftData


struct AddEmployeeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var departments: [Department]
    
    @State private var employeeName = ""
    @State private var employeePosition = ""
    @State private var selectedDepartment: Department?
    

    var body: some View {
        NavigationStack {
            Form {
                Section("Employee Details") {
                    TextField("Employee Name", text: $employeeName)
                    TextField("Position", text: $employeePosition)
              
                }
                
                Section("Assign Department") {
                    Picker("Department", selection: $selectedDepartment) {
                        ForEach(departments) { department in
                            Text(department.name).tag(department as Department?)
                        }
                    }
                }
                Section {
                    Button("Save") {
                        let newEmployee = Employee(name: employeeName, position: employeePosition, department: selectedDepartment)
                        modelContext.insert(newEmployee)
                        dismiss()
                    }
                }
            }
        }
    }
}
    
    #Preview {
        AddEmployeeView()
    }


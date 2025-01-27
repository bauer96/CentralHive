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
    @State private var selectedDepartment: Department? = nil
    

    var body: some View {
        NavigationStack {
            Form {
                Section("Employee Details") {
                    TextField("Employee Name", text: $employeeName)
                    TextField("Position", text: $employeePosition)
              
                }
                
                Section("Assign Department") {
                    Picker("Department", selection: $selectedDepartment) {
                        Text("None").tag(nil as Department?)
                        ForEach(departments) { department in
                            Text(department.name).tag(department as Department?)
                        }
                    }
                }
                Section {
                    Button("Save") {
                        createNewEmployee()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                    .disabled(employeeName.isEmpty || employeePosition.isEmpty)
                }
            }
        }
    }
    func createNewEmployee() {
        let newEmployee = Employee(name: employeeName, position: employeePosition, department: selectedDepartment)
        modelContext.insert(newEmployee)
    }
}
    
    #Preview {
        AddEmployeeView()
    }


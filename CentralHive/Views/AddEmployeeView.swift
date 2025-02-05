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
    
    @State private var employeeFirstName = ""
    @State private var employeeLastName = ""
    @State private var employeePosition = ""
    @State private var emailAddress = ""
    @State private var selectedDepartment: Department? = nil
    

    var body: some View {
        NavigationStack {
            Form {
                Section("Employee Details") {
                    TextField("First Name", text: $employeeFirstName)
                        .textContentType(.givenName)
                    TextField("Last Name", text: $employeeLastName)
                        .textContentType(.familyName)
                    TextField("Position", text: $employeePosition)
                    TextField("Emailadress: ", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
              
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
                    .disabled(employeeFirstName.isEmpty || employeeLastName.isEmpty || emailAddress.isEmpty ||  employeePosition.isEmpty)
                }
            }
        }
    }
    func createNewEmployee() {
        let newEmployee = Employee(id: UUID(), firstName: employeeFirstName , lastName: employeeLastName, position: employeePosition, emailAddress: emailAddress, department: selectedDepartment)
        modelContext.insert(newEmployee)
        try? modelContext.save()
    }
}
    
    #Preview {
        AddEmployeeView()
    }


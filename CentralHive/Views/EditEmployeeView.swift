//
//  EditEmployeeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 23.02.25.
//

import SwiftUI
import SwiftData

struct EditEmployeeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var employee: Employee
    @State private var firstName: String
    @State private var lastName: String
    @State private var position: String
    @State private var emailAddress: String
    @State private var selectedDepartment: Department?
    @Query private var departments: [Department]

    init(employee: Binding<Employee>) {
        self._employee = employee
        _firstName = State(initialValue: employee.wrappedValue.firstName)
        _lastName = State(initialValue: employee.wrappedValue.lastName)
        _position = State(initialValue: employee.wrappedValue.position)
        _emailAddress = State(initialValue: employee.wrappedValue.emailAddress)
        _selectedDepartment = State(initialValue: employee.wrappedValue.department)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Position", text: $position)
                    TextField("Email", text: $emailAddress)
                        .keyboardType(.emailAddress)
                }
                
                Section(header: Text("Department")) {
                    Picker("Select Department", selection: $selectedDepartment) {
                        ForEach(departments) { department in
                            Text(department.name).tag(department as Department?)
                        }
                    }
                }
            }
            .navigationTitle("Edit Employee")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveChanges()
                    }
                    .bold()
                }
            }
        }
    }
    
    private func saveChanges() {
        employee.firstName = firstName
        employee.lastName = lastName
        employee.position = position
        employee.emailAddress = emailAddress
        employee.department = selectedDepartment
        dismiss()
    }
}


//#Preview {
//    EditEmployeeView()
//}

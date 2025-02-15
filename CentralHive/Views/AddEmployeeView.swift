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
    @State private var selectedDepartment: Department?

   
    init(department: Department? = nil) {
        _selectedDepartment = State(initialValue: department)
        print("DEBUG: Received department:", department?.name ?? "nil") // 🔍 Debugging
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Form {
                    Section {
                        CustomTextField(placeholder: "First Name", text: $employeeFirstName)
                        CustomTextField(placeholder: "Last Name", text: $employeeLastName)
                        CustomTextField(placeholder: "Position", text: $employeePosition)
                        CustomTextField(placeholder: "Email Address", text: $emailAddress, icon: "envelope")
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    } header: {
                        Text("Employee Details")
                            .foregroundStyle(.textForeground)
                    }
                    .listRowBackground(Color(.textBackGround).opacity(0.2))

                    Section {
                        Picker("Department", selection: $selectedDepartment) {
//                            Text("None").tag(nil as Department?)
                            ForEach(departments) { department in
                                Text(department.name).tag(department as Department?)
                            }
                        }
                        .foregroundStyle(.textForeground)
                    } header: {
                        Text("Assign Department")
                            .foregroundStyle(.textForeground)
                    }
                    .listRowBackground(Color(.textBackGround).opacity(0.2))
                }
                .scrollContentBackground(.hidden)
                .frame(maxHeight: 420)

                Button(action: {
                    createNewEmployee()
                    dismiss()
                }) {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(isSaveDisabled ? Color(.textBackGround).opacity(0.2) : Color(.textForeground).opacity(0.6))
                        .foregroundColor(.iconForeground)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(isSaveDisabled)

                Spacer()
            }
            .padding(.top, 20)
            .background(Color(.background))
            .navigationTitle("Add Employee")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var isSaveDisabled: Bool {
        employeeFirstName.isEmpty || employeeLastName.isEmpty || emailAddress.isEmpty || employeePosition.isEmpty
    }

    func createNewEmployee() {
        let newEmployee = Employee(
            id: UUID(),
            firstName: employeeFirstName,
            lastName: employeeLastName,
            position: employeePosition,
            emailAddress: emailAddress,
            department: selectedDepartment
        )
        modelContext.insert(newEmployee)
        try? modelContext.save()
    }
}
//    #Preview {
//        AddEmployeeView()
//    }


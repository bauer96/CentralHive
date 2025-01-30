//
//  EmployeeDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//

import SwiftUI
import SwiftData

struct EmployeeDetailView: View {
    
    // TODO: remove ObservedObject for migration to Observable Class.. // @Bindable use check if possible? 
    @ObservedObject var employee: Employee
   
    
    @State private var isAddingHardware = false
    @State private var isEditing = false
    
    @State private var hardwareName = ""
    @State private var hardwareModel = ""
    @State private var hardwareSerialNumber = ""
    

    var body: some View {
        
            Form {
                Section("Employee Details") {
                    if isEditing {
                        TextField("Name:", text: $employee.name)
                            .font(.title)
                        TextField("Position:", text: $employee.position)
                            .font(.headline)
                    
                        
                       
                        // TextField("Department:", text: $employee.department?.name)
                    } else {
                        Text("Name: \(employee.name)")
                            .font(.title)
                        Text("Position: \(employee.position)")
                            .font(.headline)
                        Text("Department: \(employee.department?.name ?? "Not Assigned")")
                            .font(.subheadline)
                    }
                    
                    // Optional binding for hardware
                    if let hardware = employee.hardware {
                        Section(header: Text("Hardware Details")) {
                            if isEditing {
                                TextField("Hardware:", text: $hardwareName)
                                    .font(.subheadline)
                                TextField("Model:", text: $hardwareModel)
                                    .font(.subheadline)
                                TextField("Serial Number:", text: $hardwareSerialNumber)
                                    .font(.subheadline)
                            } else {
                                Text("Hardware: \(hardware.name)")
                                Text("Model: \(hardware.model)")
                                Text("Serial Number: \(hardware.serialNumber)")
                            }
                        }
                    } else {
                        Text("Hardware: Not Assigned")
                        Button("Assign Hardware") {
                            isAddingHardware.toggle()
                        }
                    }
                }
              
            }
        
        .padding()
        .navigationTitle(employee.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Update" : "Edit Mode") {
                    if isEditing {
                        // Save the updated hardware if in edit mode
                        if let hardware = employee.hardware {
                            hardware.name = hardwareName
                            hardware.model = hardwareModel
                            hardware.serialNumber = hardwareSerialNumber
                        }
                    } else {
                        // Populate the hardware fields for editing
                        if let hardware = employee.hardware {
                            hardwareName = hardware.name
                            hardwareModel = hardware.model
                            hardwareSerialNumber = hardware.serialNumber
                        }
                    }
                    isEditing.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .sheet(isPresented: $isAddingHardware) {
            AddHardwareView(employee: employee)
                .presentationDetents([.medium])// Pass the employee to AddHardwareView
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}





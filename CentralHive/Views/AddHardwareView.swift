//
//  AddHardwareView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//

import SwiftUI
import SwiftData

struct AddHardwareView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var employee: Employee
    
    @State private var hardwareName = ""
    @State private var hardwareModel = ""
    @State private var hardwareSerialNumber = ""
    
    var body: some View {
        Form {
            Section("Add Hardware") {
                TextField("Hardware Name", text: $hardwareName)
                TextField("Hardware Model", text: $hardwareModel)
                TextField("Hardware Serial Number", text: $hardwareSerialNumber)
            }
            
            Button("Save") {
                // Create new hardware with input values
                let newHardware = Hardware(id: UUID(), name: hardwareName, serialNumber: hardwareSerialNumber, model: hardwareModel)
                
                // Assign this new hardware to the employee
                employee.hardware = newHardware
                
                // Insert the new hardware into the context
                modelContext.insert(newHardware)
                
                // Dismiss the AddHardwareView
                dismiss()
            }
            .disabled(hardwareName.isEmpty || hardwareModel.isEmpty || hardwareSerialNumber.isEmpty)
        }
        .navigationTitle("Add Hardware")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    AddHardwareView()
//}

//
//  HardwareDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 27.01.25.
//

import SwiftUI
import SwiftData

struct HardwareDetailView: View {
    @State private var isAddingHardware = false
    @State private var isEditing = false
    
    @State private var hardwareName = ""
    @State private var hardwareModel = ""
    @State private var hardwareSerialNumber = ""
    
    @Bindable var hardware: Hardware
    
    var body: some View {
        Form {
            Section("Hardware Details") {
                if isEditing {
                    TextField("Name", text: $hardwareName)
                        .font(.subheadline)
                    TextField("Model", text: $hardwareModel)
                        .font(.subheadline)
                    TextField("Serial Number", text: $hardwareSerialNumber)
                        .font(.subheadline)
                } else {
                    Text("Hardware: \(hardware.name)")
                    Text("Model: \(hardware.model)")
                    Text("Serial Number: \(hardware.serialNumber)")
                }
            }
            
            Section("Assigned Employee") {
                if let employee = hardware.employee {
                    NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                        VStack(alignment: .leading) {
                            Text(employee.name)
                                .font(.headline)
                            Text(employee.position)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                } else {
                    Text("No employee assigned")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Update" : "Edit Mode") {
                    if isEditing {
                        // Save the updated hardware if in edit mode
                        hardware.name = hardwareName
                        hardware.model = hardwareModel
                        hardware.serialNumber = hardwareSerialNumber
                    } else {
                        // Populate the hardware fields for editing
                        hardwareName = hardware.name
                        hardwareModel = hardware.model
                        hardwareSerialNumber = hardware.serialNumber
                    }
                    isEditing.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Hardware.self, configurations: config)
//        let example = Hardware(name: "Laptop", serialNumber: "1245ABCQX", model: "HP EliteBook", employee: [])
//        return HardwareDetailView(hardware: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create Model Container")
//    }
//}

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
    
    // TODO: remove ObservedObject for migration to Observable Class.. // @Bindable use check if possible? 
    
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
                addHardware()
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .buttonStyle(.borderedProminent)
            .disabled(hardwareName.isEmpty || hardwareModel.isEmpty || hardwareSerialNumber.isEmpty)
        }
        .navigationTitle("Add Hardware")
        .navigationBarTitleDisplayMode(.inline)
    }
    func addHardware() {
        let newHardware = Hardware(id: UUID(), name: hardwareName, serialNumber: hardwareSerialNumber, model: hardwareModel)
        employee.hardware = newHardware
        modelContext.insert(newHardware)
    }
}


//#Preview {
//    AddHardwareView()
//}

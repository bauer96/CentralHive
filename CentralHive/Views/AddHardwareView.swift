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
    
    @State var employee: Employee
    
    @State private var hardwareName = ""
    @State private var hardwareModel = ""
    @State private var hardwareSerialNumber = ""
    @State private var hardwareOS = ""
    @State private var hardwareRAM = ""
    @State private var storage = ""
    @State private var purchaseDate = Date()
    @State private var warrantyExpiry = Calendar.current.date(byAdding: .year, value: 3, to: Date()) ?? Date()
    @State private var selectedType: HardwareType = .laptop
    
    var body: some View {
        NavigationView {
            Form {
                Section("Hardware Details") {
                    Picker("Type", selection: $selectedType) {
                        ForEach(HardwareType.allCases, id: \.self) { type in
                            Label(type.rawValue.capitalized, systemImage: hardwareTypeIcon(type))
                                .tag(type)
                        }
                    }
                    TextField("Hardware Name", text: $hardwareName)
                    TextField("Hardware Model", text: $hardwareModel)
                    TextField("Serial Number", text: $hardwareSerialNumber)
                    TextField("OS", text: $hardwareOS)
                    TextField("RAM", text: $hardwareRAM)
                    TextField("Storage", text: $storage)
                }
                
                Section("Dates") {
                    DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                    DatePicker("Warranty Expiry", selection: $warrantyExpiry, displayedComponents: .date)
                }
                
                Section {
                    Button("Save Hardware") {
                        addHardware()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderedProminent)
                    .disabled(hardwareName.isEmpty || hardwareModel.isEmpty || hardwareSerialNumber.isEmpty)
                }
            }
            .navigationTitle("Add Hardware")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func hardwareTypeIcon(_ type: HardwareType) -> String {
        switch type {
        case .laptop: return "laptopcomputer"
        case .smartphone: return "iphone"
        case .tablet: return "ipad"
        case .desktop: return "desktopcomputer"
        case .monitor: return "display"
        case .other: return "gear"
        }
    }
    
    private func addHardware() {
        let newHardware = Hardware(
            name: hardwareName,
            model: hardwareModel,
            serialNumber: hardwareSerialNumber,
            os: hardwareOS,
            ram: hardwareRAM,
            storage: storage,
            purchaseDate: purchaseDate,
            warrantyExpiry: warrantyExpiry,
            type: selectedType
        )
        
        newHardware.employee = employee
        employee.hardwareItems.append(newHardware)
        modelContext.insert(newHardware)
    }
}


//#Preview {
//    AddHardwareView()
//}

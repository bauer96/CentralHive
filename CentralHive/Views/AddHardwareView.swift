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
    @State private var warrantyExpiry = Date()
    @State private var selectedType: HardwareType = .laptop
    
    var body: some View {
        NavigationView {
            VStack(spacing: 6) {
                Form {
                    Section {
                        Picker("Type", selection: $selectedType) {
                            ForEach(HardwareType.allCases, id: \.self) { type in
                                Label(type.rawValue.capitalized, systemImage: hardwareTypeIcon(type))
                                
                                    .tag(type)
                            }
                        }
                        CustomTextField(placeholder: "Hardware Name", text: $hardwareName)
                        CustomTextField(placeholder: "Hardware Model", text: $hardwareModel)
                        CustomTextField(placeholder: "Serial Number", text: $hardwareSerialNumber)
                        CustomTextField(placeholder: "Operating System", text: $hardwareOS)
                        CustomTextField(placeholder: "RAM", text: $hardwareRAM)
                            .keyboardType(.numberPad)
                     
                        CustomTextField(placeholder: "Storage", text: $storage)
                            .keyboardType(.numberPad)
                    } header: {
                        Text("Hardware Details")
                            .foregroundStyle(.textForeground)
                    }
                    
                    Section("Dates") {
                        DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                        
                        DatePicker("Warranty Expiry", selection: $warrantyExpiry, displayedComponents: .date)
                    }
                    
                
                   
                }
                
                CustomButton(title: "Save", isDisabled: hardwareName.isEmpty) {
                    addHardware()
                    dismiss()
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
        
        let ramValue = Int(hardwareRAM.trimmingCharacters(in: .whitespaces)) ?? 0
        let storageValue = Int(storage.trimmingCharacters(in: .whitespaces)) ?? 0
        
        let newHardware = Hardware(
            name: hardwareName,
            model: hardwareModel,
            serialNumber: hardwareSerialNumber,
            os: hardwareOS,
            ram: ramValue,
            storage: storageValue,
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

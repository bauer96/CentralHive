//
//  EmployeeDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//
import SwiftUI
import SwiftData
import SwiftUI

struct EmployeeDetailView: View {
    @ObservedObject var employee: Employee
    
    @State private var isAddingHardware = false
    @State private var isEditing = false
    
    @State private var hardwareName = ""
    @State private var hardwareModel = ""
    @State private var hardwareSerialNumber = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Employee Information
                SectionBox(title: "Employee Details", icon: "person.fill") {
                    if isEditing {
                        TextField("First Name", text: $employee.firstName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name", text: $employee.lastName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Position", text: $employee.position)
                            .textFieldStyle(.roundedBorder)
                        TextField("Email", text: $employee.emailAddress)
                            .textFieldStyle(.roundedBorder)
                    } else {
                        InfoRow(label: "Name", value: "\(employee.firstName) \(employee.lastName)")
                        InfoRow(label: "Position", value: employee.position)
                        InfoRow(label: "Email", value: employee.emailAddress)
                        InfoRow(label: "Department", value: employee.department?.name ?? "Not Assigned")
                    }
                }
                
                // Hardware Information
                if let hardware = employee.hardware {
                    SectionBox(title: "Assigned Hardware", icon: "desktopcomputer") {
                        if isEditing {
                            TextField("Hardware Name", text: $hardwareName)
                                .textFieldStyle(.roundedBorder)
                            TextField("Model", text: $hardwareModel)
                                .textFieldStyle(.roundedBorder)
                            TextField("Serial Number", text: $hardwareSerialNumber)
                                .textFieldStyle(.roundedBorder)
                        } else {
                            InfoRow(label: "Hardware", value: hardware.name)
                            InfoRow(label: "Model", value: hardware.model)
                            InfoRow(label: "Serial Number", value: hardware.serialNumber)
                            InfoRow(label: "OS", value: hardware.os)
                            InfoRow(label: "RAM", value: hardware.ram)
                            InfoRow(label: "Storage", value: hardware.storage)
                            InfoRow(label: "Purchase Date", value: hardware.purchaseDate?.formatted() ?? "No Purchase Date")

                            InfoRow(label: "Waranty Expire", value: hardware.warrantyExpiry?.formatted() ?? "No Waranty found")
                        }
                    }
                } else {
                    Button(action: { isAddingHardware.toggle() }) {
                        Label("Assign Hardware", systemImage: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                
//                // Sample Hardware Inventory
//                SectionBox(title: "Laptop", icon: "laptopcomputer") {
//                    InfoRow(label: "Model", value: "HP EliteBook 840 G10")
//                    InfoRow(label: "Serial Number", value: "ABCXED2123JG", monospaced: true)
//                    InfoRow(label: "OS", value: "Windows 11")
//                    InfoRow(label: "RAM", value: "16GB")
//                    InfoRow(label: "Color", value: "Space Gray")
//                }
//                
//                SectionBox(title: "Phone", icon: "iphone") {
//                    InfoRow(label: "Model", value: "iPhone 14")
//                    InfoRow(label: "Serial Number", value: "ABCEXEDSA123JH", monospaced: true)
//                    InfoRow(label: "OS", value: "iOS")
//                    InfoRow(label: "Provider", value: "Vodafone")
//                }
                
            }
            .padding()
        }
        .navigationTitle("\(employee.firstName) \(employee.lastName)")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        if let hardware = employee.hardware {
                            hardware.name = hardwareName
                            hardware.model = hardwareModel
                            hardware.serialNumber = hardwareSerialNumber
                        }
                    } else {
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
            AddHardwareView(
                employee: employee,
                purchaseDate: employee.hardware?.purchaseDate ?? Date(), // Default to today if nil
                warantyExpiry: employee.hardware?.warrantyExpiry ?? Calendar.current.date(byAdding: .year, value: 3, to: Date())! // Default to 3 years from today if nil
            )
                .presentationDetents([.medium])
        }
    }
}

// MARK: - UI Components

struct SectionBox<Content: View>: View {
    var title: String
    var icon: String
    var content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
            }
            .padding(.bottom, 4)
            
            VStack(alignment: .leading, spacing: 4) {
                content
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

struct InfoRow: View {
    var label: String
    var value: String
    var monospaced: Bool = false
    
    var body: some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .font(monospaced ? .system(.body, design: .monospaced) : .body)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 2)
    }
}




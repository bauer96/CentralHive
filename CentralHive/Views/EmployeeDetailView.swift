//
//  EmployeeDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
import SwiftUI
import SwiftData

struct EmployeeDetailView: View {
    @State var employee: Employee
    @State private var isAddingHardware = false
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Employee Information section remains the same
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
                
                // Hardware Cards Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "desktopcomputer")
                            .foregroundColor(.blue)
                        Text("Hardware Details")
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(employee.hardwareItems) { hardware in
                            // Hardware Card
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: hardwareTypeIcon(hardware.type ?? .other))
                                    Text((hardware.type ?? .other).rawValue.capitalized)
                                        .font(.headline)
                                }
                                .padding(.bottom, 4)
                                
                                InfoRow(label: "Name", value: hardware.name)
                                InfoRow(label: "Model", value: hardware.model)
                                InfoRow(label: "Serial Number", value: hardware.serialNumber)
                                InfoRow(label: "OS", value: hardware.os)
                                InfoRow(label: "RAM", value: hardware.ram)
                                InfoRow(label: "Storage", value: hardware.storage)
                                InfoRow(label: "Purchase Date", value: hardware.purchaseDate?.formatted() ?? "No Purchase Date")
                                InfoRow(label: "Warranty Expire", value: hardware.warrantyExpiry?.formatted() ?? "No Warranty found")
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        Button(action: { isAddingHardware.toggle() }) {
                            Label("Add Hardware", systemImage: "plus.circle.fill")
                                .foregroundStyle(.blue)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("\(employee.firstName) \(employee.lastName)")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Save" : "Edit") {
                    isEditing.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .sheet(isPresented: $isAddingHardware) {
            AddHardwareView(employee: employee)
                .presentationDetents([.medium])
        }
    }
    
    // hardwareTypeIcon function remains the same
    func hardwareTypeIcon(_ type: HardwareType) -> String {
        switch type {
        case .laptop: return "laptopcomputer"
        case .smartphone: return "iphone"
        case .tablet: return "ipad"
        case .desktop: return "desktopcomputer"
        case .monitor: return "display"
        case .other: return "gear"
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




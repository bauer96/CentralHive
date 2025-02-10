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
    @State private var expandedHardwareIDs: Set<UUID> = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                SectionBox(title: "Employee Details", icon: "person.fill") {
                    InfoRow(label: "Name", value: "\(employee.firstName) \(employee.lastName)")
                    InfoRow(label: "Position", value: employee.position)
                    InfoRow(label: "Email", value: employee.emailAddress)
                    InfoRow(label: "Department", value: employee.department?.name ?? "Not Assigned")
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "desktopcomputer")
                            .foregroundColor(.blue)
                        Text("Hardware Details")
                            .font(.headline)
                    }
                    .padding(.horizontal)

                    if employee.hardwareItems.isEmpty {
                        Text("No hardware assigned.")
                            .foregroundColor(.gray)
                            .italic()
                            .padding(.horizontal)
                    }

                    VStack(spacing: 16) {
                        ForEach(employee.hardwareItems) { hardware in
                            VStack {
                                HStack {
                                    Image(systemName: hardwareTypeIcon(hardware.type ?? .other))
                                        .foregroundColor(.blue)
                                        .font(.system(size: 20))
                                        .frame(width: 24, height: 24)

                                    Text(hardware.name)
                                        .font(.headline)

                                    Spacer()

                                    Button(action: {
                                        if expandedHardwareIDs.contains(hardware.id) {
                                            expandedHardwareIDs.remove(hardware.id)
                                        } else {
                                            expandedHardwareIDs.insert(hardware.id)
                                        }
                                    }) {
                                        Image(systemName: expandedHardwareIDs.contains(hardware.id) ? "chevron.up" : "chevron.down")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()

                                if expandedHardwareIDs.contains(hardware.id) {
                                    Divider()
                                    VStack(alignment: .leading, spacing: 4) {
                                     
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
                                    .transition(.opacity)
                                }
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        
                        // Button wird IMMER angezeigt
                        Button(action: { isAddingHardware.toggle() }) {
                            Label("Add Hardware", systemImage: "plus.circle.fill")
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("\(employee.firstName) \(employee.lastName)")
        .sheet(isPresented: $isAddingHardware) {
            AddHardwareView(employee: employee)
                .presentationDetents([.medium])
        }
    }
}

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




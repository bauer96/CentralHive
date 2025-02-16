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
                            .foregroundColor(.iconForeground)
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
                                        .foregroundColor(.iconForeground)
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
                                            .foregroundColor(.iconForeground)
                                    }
                                }
                                .padding()

                                if expandedHardwareIDs.contains(hardware.id) {
                                    Divider()
                                    VStack(alignment: .leading, spacing: 4) {
                                     
                                        InfoRow(label: "Model", value: hardware.model)
                                        InfoRow(label: "Serial Number", value: hardware.serialNumber)
                                        InfoRow(label: "OS", value: hardware.os)
                                        InfoRow(label: "RAM", value: hardware.formattedRAM)
                                        InfoRow(label: "Storage", value: hardware.formattedStorage)
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
                        
                       
                        Button(action: { isAddingHardware.toggle() }) {
                            Label("Add Hardware", systemImage: "plus.circle")
                                .foregroundColor(.iconForeground)
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
                .presentationDetents([.large])
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






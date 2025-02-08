//
//  DepartmentDetailView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 22.01.25.
//
import SwiftUI
import SwiftData

struct DepartmentDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var department: Department
    @State private var isAddingEmployee = false

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Number of Employees: \(department.employees.count)")
                    .font(.headline)
                    .padding(.vertical)
                
                VStack(spacing: 25) {
                    ForEach(department.employees) { employee in
                        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                            VStack(alignment: .leading, spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(employee.firstName) \(employee.lastName)")
                                        .font(.headline)
                                    Text(employee.position)
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                                
                                // Hardware section
                                if employee.hardwareItems.isEmpty {
                                    Text("No Hardware")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .padding(6)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                } else {
                                    HStack(spacing: 8) {
                                        ForEach(Array(Set(employee.hardwareItems.compactMap { $0.type })), id: \.self) { type in
                                            Image(systemName: hardwareTypeIcon(type))
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(department.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isAddingEmployee.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingEmployee) {
            AddEmployeeView()
                .presentationDetents([.medium])
        }
        .navigationBarTitleDisplayMode(.inline)
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


//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: [Employee.self,Department.self], configurations: config)
//
//        let exampleDepartment = Department(id: UUID(), name: "IT", employees: [])
//        return DepartmentDetailView()
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to Create Model Container")
//    }
//}

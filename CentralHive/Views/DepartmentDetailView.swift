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
    @State private var showDeleteAlert = false
    @State private var employeeToDelete: Employee?
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isErrorToast = false
   

    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 10) {
                    
                    HStack {
                        Image(systemName: department.employees.count == 1 ? "person.fill" : "person.3.fill")
                        Text(String.localizedStringWithFormat("%d %@", department.employees.count, department.employees.count == 1 ? "Employee " : "Employees"))
                            .foregroundStyle(.secondary)
                     
                    }
                    .padding(.vertical)
                    
                    VStack(spacing: 10) {
                        ForEach(department.employees) { employee in
                            ZStack(alignment: .topTrailing) {
                                NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                                    VStack(alignment: .leading, spacing: 12) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("\(employee.firstName) \(employee.lastName)")
                                                .font(.headline)
                                            Text("\(employee.position) \(department.name)")
                                                .font(.subheadline)
                                                .foregroundStyle(.gray)
                                        }
                                        
                                        // Hardware section
                                        if employee.hardwareItems.isEmpty {
                                            Text("No Hardware")
                                                .font(.subheadline)
                                                .foregroundStyle(.iconForeground)
                                                .padding(6)
                                                .background(Color(.background))
                                                .cornerRadius(8)
                                        } else {
                                            HStack(spacing: 8) {
                                                ForEach(Array(Set(employee.hardwareItems.compactMap { $0.type })), id: \.self) { type in
                                                    Image(systemName: hardwareTypeIcon(type))
                                                        .foregroundStyle(.iconForeground)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.textBackGround).opacity(0.10))
                                    .cornerRadius(15)
                                  
                                }
                             .buttonStyle(PlainButtonStyle())
                                
                                // Delete button
                                Button(action: {
                                    employeeToDelete = employee
                                    showDeleteAlert = true
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.gray)
                                    
                                }
                                .offset(x: -8, y: 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        
        .navigationTitle(department.name)
        .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if let employee = employeeToDelete {
                    do {
                        try deleteEmployee(employee)
                        toastMessage = "Employee successfully deleted"
                        isErrorToast = false
                    } catch {
                        toastMessage = "Error deleting employee"
                        isErrorToast = true
                    }
                    showToast = true
                }
            }
        } message: {
            Text("Are you sure you want to delete this employee? This action cannot be undone.")
                .font(.title)
            
        }
        .toast(isShowing: $showToast, message: toastMessage, isError: isErrorToast)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("DEBUG: Opening AddEmployeeView with department:", department.name)
                    isAddingEmployee.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingEmployee) {
            AddEmployeeView(department: department)
                .presentationDetents([.large])
        }
        .navigationBarTitleDisplayMode(.inline)
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
    
    func deleteEmployee(_ employee: Employee) throws {
        do {
            department.employees.removeAll { $0.id == employee.id }
            modelContext.delete(employee)
            try modelContext.save()
        } catch {
            throw error
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

//
//  EmployeeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//


import SwiftUI
import SwiftData

struct EmployeeListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isAddingEmployee = false
    @Query var employees: [Employee]
    @State private var searchText = ""
    @State private var showDeleteAlert = false
    @State private var employeeToDelete: Employee?
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isErrorToast = false
    
    var searchResults: [Employee] {
        if searchText.isEmpty {
            return employees
        } else {
            return employees.filter {
                $0.lastName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea()
                
                ScrollView {
                        
                        VStack(spacing: 10) {
                            ForEach(searchResults) { employee in
                                ZStack(alignment: .topTrailing) {
                                    NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                                        VStack(alignment: .leading, spacing: 12) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("\(employee.firstName) \(employee.lastName)")
                                                    .font(.headline)
                                            }
                                            
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
                            .searchable(text: $searchText, prompt: "Search employees...")
                        }
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Employees")
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
                    .presentationDetents([.large])
            }
            .navigationBarTitleDisplayMode(.automatic)
        }
    
       
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
     
    }
    
    func deleteEmployee(_ employee: Employee) throws {
        do {
            modelContext.delete(employee)
            try modelContext.save()
        } catch {
            throw error
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
}



#Preview {
    EmployeeListView()
}

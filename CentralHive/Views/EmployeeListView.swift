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
    @State private var path = [Employee]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(employees) { employee in
                    NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(employee.firstName) \(employee.lastName)")
                                    .font(.headline)
                                Text(employee.position)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                
                                Spacer()
                                    .frame(height: 15)
                                
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
                            
                          
                      
                        }
                    }
                }
                .onDelete(perform: deleteEmployees)
            }
            .scrollContentBackground(.hidden)
            .background(Color(.background))
            
            
            .navigationTitle("Employees")
            .navigationDestination(for: Employee.self, destination: EmployeeDetailView.init)
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
        }
    }
    
    func deleteEmployees(_ indexSet: IndexSet) {
        for index in indexSet {
            let employee = employees[index]
            modelContext.delete(employee)
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

// Preview remains the same
#Preview {
    EmployeeListView()
}

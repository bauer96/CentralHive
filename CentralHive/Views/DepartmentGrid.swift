//
//  DepartmentGrid.swift
//  CentralHive
//
//  Created by Hannes Bauer on 15.02.25.
//

import SwiftUI
import SwiftData

struct DepartmentGrid: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showDeleteAlert = false
    @State private var departmentToDelete: Department?
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isErrorToast = false
    @Query var departments: [Department]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(departments) { department in
                    DepartmentCard(department: department)
                        .contextMenu {
                            Button(role: .destructive) {
                                departmentToDelete = department
                                showDeleteAlert = true
                               
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if let department = departmentToDelete {
                    do {
                        try deleteDepartment(department)
                        toastMessage = "Department successfully deleted"
                        isErrorToast = false
                    } catch {
                        toastMessage = "Error deleting Department"
                        isErrorToast = true
                    }
                    showToast = true
                }
            }
        } message: {
            Text("Are you sure you want to delete this Department? This action cannot be undone.")
                .font(.title)
            
        }
        .toast(isShowing: $showToast, message: toastMessage, isError: isErrorToast)
        .scrollContentBackground(.hidden)
        .background(Color(.background))
    }
    
    func deleteDepartment(_ department: Department) {
        modelContext.delete(department) 
        try? modelContext.save() // Save the context after deletion
    }
}

//#Preview {
//    DepartmentGrid()
//}

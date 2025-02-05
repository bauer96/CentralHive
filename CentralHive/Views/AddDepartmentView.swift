//
//  AddDepartmentView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//
import SwiftUI
import SwiftData


struct AddDepartmentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var departmentName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Department Details") {
                    TextField("Department Name", text: $departmentName)
                   
                }
                Button("Save") {
                    addDepartment()
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(departmentName.isEmpty)
            }
            .navigationTitle("Add Department")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func addDepartment() {
        let newDepartment = Department(name: departmentName)
        modelContext.insert(newDepartment)
    }
}

#Preview {
    AddDepartmentView()
}

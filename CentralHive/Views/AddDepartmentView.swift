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
                Section {
                    TextField("Department Name", text: $departmentName)
                   
                }
                Button("Speichern") {
                    let newDepartment = Department(name: departmentName)
                    modelContext.insert(newDepartment)
                    dismiss()
                }
            }
            .navigationTitle("Add Department")
        }
    }
}

#Preview {
    AddDepartmentView()
}

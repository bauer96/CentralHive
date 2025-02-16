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
            VStack(spacing: 6) {
                Form {
                    Section {
                        CustomTextField(placeholder: "Department", text: $departmentName)

                    } header: {
                        Text("Department Details")
                            .foregroundStyle(.textForeground)
                    }
                    .listRowBackground(Color(.textBackGround).opacity(0.2))
                }
                .frame(maxHeight: 150)
                
               
                CustomButton(title: "Save", isDisabled: departmentName.isEmpty) {
                    addDepartment()
                    dismiss()
                }

                Spacer() 
                   
            }
            
            .scrollContentBackground(.hidden)
            .background(Color(.background))
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

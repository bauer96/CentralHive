//
//  EmptyDepartmentView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 15.02.25.
//

import SwiftUI

struct EmptyDepartmentView: View {
    
    @State private var isAddingDepartment = false
    
    var body: some View {
        ContentUnavailableView {
            Label("Welcome to CentralHive", systemImage: "rectangle.stack.fill.badge.plus")
                .foregroundStyle(.iconForeground)
        } description: {
            Text("Manage Employees and Hardware")
                .foregroundStyle(.textForeground)
        } actions: {
            Button("Create Department") {
                isAddingDepartment.toggle()
            }
            .foregroundColor(.background)
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $isAddingDepartment) {
            AddDepartmentView()
                .presentationDetents([.large])
        }
        .background(Color(.background))
    }
    }


#Preview {
    EmptyDepartmentView()
}

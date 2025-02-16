//
//  DepartmentCard.swift
//  CentralHive
//
//  Created by Hannes Bauer on 15.02.25.
//

import SwiftUI
import SwiftData


struct DepartmentCard: View {
     var department: Department
    
    var body: some View {
        NavigationLink(destination: DepartmentDetailView(department: department)) {
            VStack {
                HStack {
                    
                    VStack {
                        Text(department.name)
                            .font(.headline)
                            .foregroundStyle(.textForeground)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("\(department.employees.count) Employees")
                                .foregroundStyle(.secondary)
                         
                        }
                        .font(.subheadline)
                        .padding(.top, 3)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background(Color(.textBackGround).opacity(0.05))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
            .background(Color(.textBackGround).opacity(0.2))
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}

//#Preview {
//    DepartmentCard()
//}

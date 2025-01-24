//
//  EmployeeView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI
import SwiftData


struct EmployeeListView: View {
    @State private var isAddingEmployee = false
    @Query var employees: [Employee]
    
    var body: some View {
        NavigationStack {
            Text("EmployeeListView")
            List(employees) { employee in
                NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                    Text(employee.name)
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
            }
            }
        
        
        }
    }

#Preview {
    EmployeeListView()
}

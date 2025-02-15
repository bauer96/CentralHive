//
//  DepartmentGrid.swift
//  CentralHive
//
//  Created by Hannes Bauer on 15.02.25.
//

import SwiftUI
import SwiftData

struct DepartmentGrid: View {
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
                }
            }
            .padding(.horizontal)
        }
        .scrollContentBackground(.hidden)
        .background(Color(.background))
    }
}

#Preview {
    DepartmentGrid()
}

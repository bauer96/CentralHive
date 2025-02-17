//
//  AboutView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 17.02.25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("CentralHive.io")
                .foregroundStyle(.iconForeground)
                .font(.headline)
            Text("Manage your Hardware and Employees")
                .font(.caption)
                .foregroundStyle(.textForeground)
            
        }
       
    }
}

#Preview {
    AboutView()
}

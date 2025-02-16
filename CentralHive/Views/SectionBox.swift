//
//  SectionBox.swift
//  CentralHive
//
//  Created by Hannes Bauer on 16.02.25.
//

import SwiftUI

struct SectionBox<Content: View>: View {
    var title: String
    var icon: String
    var content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.iconForeground)
                Text(title)
                    .font(.headline)
            }
            .padding(.bottom, 4)
            
            VStack(alignment: .leading, spacing: 8) {
                content
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

struct InfoRow: View {
    var label: String
    var value: String
    var monospaced: Bool = false
    
    var body: some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .font(monospaced ? .system(.body, design: .monospaced) : .body)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 2)
    }
}

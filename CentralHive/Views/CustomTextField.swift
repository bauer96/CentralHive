//
//  CustomTextField.swift
//  CentralHive
//
//  Created by Hannes Bauer on 13.02.25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var icon: String? = nil // Optional SF Symbol
    var placeholderColor: Color = .textForeground
    var textColor: Color = .textForeground

    var body: some View {
        ZStack(alignment: .leading) {
           
            if text.isEmpty {
                HStack {
                    if let icon = icon {
                        Image(systemName: icon)
                            .foregroundColor(.iconForeground)
                            .padding(.leading, 10)
                    }
                    Text(placeholder)
                        .foregroundColor(placeholderColor)
                        .padding(.leading, icon == nil ? 10 : 5)
                }
            }

           
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(.iconForeground)
                        .padding(.leading, 10)
                }
                TextField("", text: $text)
                    .foregroundColor(textColor)
                    .padding(.leading, icon == nil ? 10 : 5)
            }
        }
        .frame(height: 44)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}



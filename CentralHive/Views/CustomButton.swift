//
//  CustomButton.swift
//  CentralHive
//
//  Created by Hannes Bauer on 16.02.25.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var isDisabled: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isDisabled ? Color(.textBackGround) : Color(.textForeground).opacity(0.4))
                .foregroundColor(isDisabled ? Color.gray : Color(.iconForeground))
                .cornerRadius(10)
               
        }
        .padding(.horizontal)
        .disabled(isDisabled)
    }
}


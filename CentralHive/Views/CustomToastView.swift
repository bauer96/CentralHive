//
//  CustomToastView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 11.02.25.
//

import SwiftUI

struct CustomToastView: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let isError: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: isError ? "xmark.circle.fill" : "checkmark.circle.fill")
                            .foregroundStyle(.white)
                        Text(message)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(isError ? .red : .green)
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
                }
            }
        }
    }
}


extension View {
    func toast(isShowing: Binding<Bool>, message: String, isError: Bool = false) -> some View {
        modifier(CustomToastView(isShowing: isShowing, message: message, isError: isError))
    }
}

//#Preview {
//    CustomToastView()
//}

//
//  LoginTextFieldStyle.swift
//  HARUCHI
//
//  Created by 이건우 on 8/11/24.
//

import SwiftUI

struct LoginTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.haruchi(.button12))
            .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.gray1) // Color.gray1에 대한 대체
            )
    }
}

@ViewBuilder
func LoginTextField(placeholder: String, text: Binding<String>) -> some View {
    TextField(placeholder, text: text)
        .modifier(LoginTextFieldStyle())
}

@ViewBuilder
func LoginSecureField(placeholder: String, text: Binding<String>) -> some View {
    SecureField(placeholder, text: text)
        .modifier(LoginTextFieldStyle())
}


// Usage example:
/*
struct ContentView: View {
    @State private var email: String = ""
    
    var body: some View {
        CustomTextField(placeholder: "Enter your email", text: $email)
            .padding()
    }
}
*/


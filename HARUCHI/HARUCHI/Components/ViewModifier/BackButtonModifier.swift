//
//  BackButtonModifier.swift
//  HARUCHI
//
//  Created by 이건우 on 7/21/24.
//

import SwiftUI

import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

extension View {
    func backButtonStyle() -> some View {
        self.modifier(BackButtonModifier())
    }
}

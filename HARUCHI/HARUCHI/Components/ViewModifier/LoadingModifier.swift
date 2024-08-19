//
//  LoadingModifier.swift
//  HARUCHI
//
//  Created by 이건우 on 8/19/24.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                LoadingView()
            }
        }
    }
}

extension View {
    func loadingOverlay(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
}

//
//  AppState.swift
//  HARUCHI
//
//  Created by 이건우 on 8/12/24.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var path = NavigationPath()
    
    init(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
}

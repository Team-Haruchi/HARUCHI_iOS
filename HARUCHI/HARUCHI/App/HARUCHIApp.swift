//
//  HARUCHIApp.swift
//  HARUCHI
//
//  Created by 이건우 on 7/12/24.
//

import SwiftUI

@main
struct HARUCHIApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont(name: "Pretendard-SemiBold", size: 20)!]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

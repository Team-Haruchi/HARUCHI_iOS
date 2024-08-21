//
//  RootView.swift
//  HARUCHI
//
//  Created by 이건우 on 8/13/24.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.path) {
            if !appState.isLoggedIn {
                LoginView(appState: appState)
            } else {
                TabView {
                    HomeMainView()
                        .tabItem {
                            Image("tabbar_home")
                            Text("홈")
                        }
                    BudgetMainView()
                        .environmentObject(BudgetMainViewModel())
                        .environmentObject(CalendarViewModel())
                        .tabItem {
                            Image("tabbar_checkBook")
                            Text("예산")
                        }
                    DetailMainView()
                        .tabItem {
                            Image("tabbar_menu")
                            Text("더보기")
                        }
                }
            }
        }
        .environmentObject(appState)
    }
}

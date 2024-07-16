//
//  ContentView.swift
//  HARUCHI
//
//  Created by 이건우 on 7/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("홈화면")
                .tabItem {
                    Image("Home")
                    Text("홈")
                }
            Text("예산창")
                .tabItem {
                    Image("Check Book")
                    Text("예산")
                }
            Text("사이클 분석")
                .tabItem {
                    Image("Graph")
                    Text("분석")
                }
            Text("메뉴")
                .tabItem {
                    Image("Menu")
                    Text("더보기")
                }
        }
        
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.haruchiGrey81)
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}

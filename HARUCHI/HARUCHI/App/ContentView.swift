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
            Text("홈")
                .tabItem {
                    Image("tabbar_home")
                    Text("홈")
                }
            Text("예산")
                .tabItem {
                    Image("tabbar_checkBook")
                    Text("예산")
                }
            Text("더보기")
                .tabItem {
                    Image("tabbar_menu")
                    Text("더보기")
                }
        }
    }
}

#Preview {
    ContentView()
}

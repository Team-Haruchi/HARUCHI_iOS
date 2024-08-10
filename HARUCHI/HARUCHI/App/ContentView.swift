import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeMainView()
                .tabItem {
                    Image("tabbar_home")
                    Text("홈")
                }
            Text("예산")
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

#Preview {
    ContentView()
}

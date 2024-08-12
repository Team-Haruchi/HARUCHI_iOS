import SwiftUI

@main
struct HARUCHIApp: App {
    
    init() {
        HARUCHIApp.setUpNavBar()
    }
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                StartView()
            } else {
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
        .environmentObject(appState)
    }
}

private extension HARUCHIApp {
    static func setUpNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont(name: "Pretendard-SemiBold", size: 20)!]
        appearance.configureWithOpaqueBackground() // 불투명 배경
        appearance.backgroundColor = UIColor.white // 배경색 설정
        appearance.shadowColor = UIColor.clear // 그림자 제거
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // 스크롤 시의 외관 설정
    }
}

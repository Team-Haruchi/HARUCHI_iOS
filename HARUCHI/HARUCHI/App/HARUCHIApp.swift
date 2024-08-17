import SwiftUI

@main
struct HARUCHIApp: App {
    var accessToken: String = "access_token_here"
    
    init() {
        HARUCHIApp.setUpNavBar()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(accessToken: accessToken)
        }
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

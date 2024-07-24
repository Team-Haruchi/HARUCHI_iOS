//
//  HomeMainView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/23/24.
//

import SwiftUI

struct HomeMainView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            // 로고, 알림창
            HStack {
                Image("HomeLogo")
                Image("HomeAlarm")
            }
            .padding(.top, 54)
            .padding(.horizontal, 24)
            
        }
    }
}

#Preview {
    HomeMainView()
}

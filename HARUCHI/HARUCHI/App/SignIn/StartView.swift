//
//  StartView.swift
//  HARUCHI
//
//  Created by 이건우 on 7/21/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                
                Image("splash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding(.horizontal, 74)
                
                Spacer()
                
                NavigationLink(destination: SignInView()) {
                    Text("이메일로 시작하기")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 48, height: 45)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color(uiColor: UIColor(red: 66/255, green: 159/255, blue: 253/255, alpha: 1))))
                        .padding(.bottom, 17)
                }
            }
        }
    }
}

//
//  OnboardingView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/21/24.
//

import SwiftUI

struct OnboardingBudgetView: View {
    @State var text = ""
    @State private var tag: Int? = nil

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("한 달 예산을 정해볼까요?")
                        .font(.haruchi(.h1))
                        .foregroundColor(Color.black)
                        .padding(.bottom, 14)
                    
                    Text("예산을 설정하고 계획적으로 관리해보세요.")
                        .font(.haruchi(.button12))
                        .foregroundColor(.gray7)
                }
                .frame(width: 237, height: 65)
                .padding(.top, 124)
                .padding(.leading, 24)
                
                HStack(alignment: .center) {
                    Text("한 달 예산")
                        .font(.haruchi(.body_r16))
                        .padding(.vertical, 5)
                    
                    
                    TextField("0", text: $text)
                        .font(.haruchi(.h2))
                        .foregroundColor(.gray6)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .padding(.vertical, 5)
                    
                    
                    Text("원")
                        .font(.haruchi(.h2))
                        .foregroundColor(.gray6)
                        .padding(.leading, 8)
                        .padding(.vertical, 5)
                }
                .overlay(Rectangle().foregroundColor(Color.gray5).frame(height: 1).padding(.top, 7), alignment: .bottom)
                
                .padding(.top, 333)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .frame(width: 345, height: 31)
                
                Spacer()
                
                NavigationLink(destination: OnboardingNicknameView(), tag: 1, selection: $tag) {
                    EmptyView()
                }
            }
            .ignoresSafeArea(.keyboard)
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    KeypadButton(
                        text: "다음", enable: !text.isEmpty, action: { self.tag = 1 }
                    )
                }
            }
        }
    }
}

#Preview {
    OnboardingBudgetView()
}

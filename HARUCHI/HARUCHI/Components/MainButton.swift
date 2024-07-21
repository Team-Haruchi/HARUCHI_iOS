//
//  MainButton.swift
//  HARUCHI
//
//  Created by 이건우 on 7/15/24.
//

import SwiftUI

struct MainButton: View {
    
    private var text: String
    private var enable: Bool
    private var description: String
    private var action: () -> Void
    
    init(
        text: String,
        enable: Bool = true,
        description: String = "",
        action: @escaping () -> Void
    ) {
        self.text = text
        self.enable = enable
        self.description = description
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                Text(text)
                    .font(.haruchi(.button14))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 45)
                    .background(RoundedRectangle(cornerRadius: 14).fill(enable ? Color.mainBlue : Color.sub2Blue))
            }
            .disabled(!enable)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    VStack(spacing: 30) {
        MainButton(text: "활성화 버튼", description: "관심 주제는 얼마든지 마이프로필에서 수정 가능해요!") {}
            .border(.gray)
        MainButton(text: "비활성화 버튼", enable: false) {}
            .border(.gray)
    }
    .padding(.horizontal)
}

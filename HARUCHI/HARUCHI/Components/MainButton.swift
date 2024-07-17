//
//  MainButton.swift
//  HARUCHI
//
//  Created by 이건우 on 7/15/24.
//

import SwiftUI

struct MainButton: View {
    // 디자인 관련 확정 후 색상코드 수정 필요
    private let disable: Color = Color(uiColor: UIColor(red: 183/255, green: 219/255, blue: 254/255, alpha: 1))
    private let able: Color = Color(uiColor: UIColor(red: 66/255, green: 159/255, blue: 253/255, alpha: 1))
    
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
            Text(description)
                .font(.haruchi(size: 13, weight: 700))
                .foregroundStyle(Color.haruchiGrey81)
                .padding(.bottom, 14)
            Button(action: action) {
                Text(text)
                    .font(.haruchi(size: 15, weight: 700))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 45)
                    .background(RoundedRectangle(cornerRadius: 14).fill(enable ? able : disable))
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

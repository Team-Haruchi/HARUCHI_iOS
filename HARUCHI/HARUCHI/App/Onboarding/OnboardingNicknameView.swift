//
//  OnboardingNicknameView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/22/24.
//

import SwiftUI

struct OnboardingNicknameView: View {
    @State var text = ""

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("가입을 축하드려요!")
                     
                Text("어떻게 불러드리면 될까요?")
            }
            .font(.haruchi(.h1))
            .foregroundColor(Color.black)
            .padding(.bottom, 14)
            .frame(width: 253, height: 64)
            .padding(.top, 124)
            .padding(.leading, 4)

            HStack(alignment: .center) {
                TextField("(한글) 5글자 내로 입력해주세요.", text: $text)
                    .font(.haruchi(.h2))
                    .foregroundColor(.gray6)
                    .keyboardType(.default)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 5)
            }
            .padding(.top, 333)
            .padding(.leading, 4)
            .padding(.trailing, 4)
            .frame(width: 345, height: 31)
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
        
        .toolbar {
            // action 나중에 바꿔야됨
            ToolbarItemGroup(placement: .keyboard) {
                KeypadButton(
                    text: "가입완료", enable: !text.isEmpty, action: { print("버튼 눌림 ㅇㅇ") }
                )
            }
        }
    }
}


#Preview {
    OnboardingNicknameView()
}

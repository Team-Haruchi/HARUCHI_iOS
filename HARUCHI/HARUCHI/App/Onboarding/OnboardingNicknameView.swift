//
//  OnboardingNicknameView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/22/24.
//

import SwiftUI
import Combine

enum TextLengthStatus {
    case valid
    case invalid
    case `default`
}

struct OnboardingNicknameView: View {
    @State var text = ""
    @State private var limitLength: TextLengthStatus = .default
    private let maxLength = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("가입을 축하드려요!")
                    .padding(.bottom, 7)
                Text("어떻게 불러드리면 될까요?")
            }
            .font(.haruchi(.h1))
            .foregroundColor(Color.black)
            .frame(width: 253, height: 64)
            .padding(.leading, 24)
            
            Spacer().frame(height: 183)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center) {
                    TextField("(한글) 5글자 내로 입력해주세요.", text: $text)
                        .font(.haruchi(.h2))
                        .foregroundColor(limitLength == .invalid ? Color.black : Color.red)
                        .keyboardType(.default)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                    
                        .onChange(of: text) { newValue in
                            self.validateAndLimitText()
                        }
                }
                .padding(.leading, 24)
                .frame(width: 344, height: 24)
                
                HStack {
                    Text(limitLength == .invalid ? "올바르지 않은 형식입니다." : "")
                        .font(.haruchi(.caption3))
                        .foregroundColor(Color.red)
                    Spacer()
                    Text("\(text.count)/\(maxLength)")
                        .font(.haruchi(.caption3))
                        .foregroundColor(text.count > maxLength ? Color.red : Color.black)
                }
                .padding(.top, 4)
                .padding(.leading, 24)
                .padding(.trailing, 24)
            }
            .padding(.top, 30)
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
    
    private func validateAndLimitText() {
        if text.count > maxLength {
            text = String(text.prefix(maxLength))
            limitLength = .valid
        } else if text.isEmpty || !isKoreanOrEnglish(text) {
            limitLength = .invalid
        } else {
            limitLength = .valid
        }
    }

    private func isKoreanOrEnglish(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: input.utf16.count)
            if regex.firstMatch(in: input, options: [], range: range) != nil {
                return true
            }
        }
        return false
    }
}

#Preview {
    OnboardingNicknameView()
}

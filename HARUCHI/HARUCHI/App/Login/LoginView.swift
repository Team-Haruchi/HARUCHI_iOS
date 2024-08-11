//
//  LoginView.swift
//  HARUCHI
//
//  Created by 이건우 on 8/11/24.
//

import SwiftUI

fileprivate enum LoginTextFieldType {
    case email
    case password
}

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @FocusState private var focusedField: LoginTextFieldType?
    
    var body: some View {
        VStack(spacing: 0) {
            Text("지출 통제, 하루치 예산으로")
                .font(.haruchi(size: 20, family: .SemiBold))
                .padding(.bottom, 25)
            
            Image("mainLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 74)
                .padding(.bottom, 50)
            
            Group {
                LoginTextField(
                    placeholder: "이메일",
                    text: $loginViewModel.email
                )
                .focused($focusedField, equals: .email)
                .padding(.bottom, 25)
                
                LoginSecureField(
                    placeholder: "비밀번호",
                    text: $loginViewModel.password
                )
                .focused($focusedField, equals: .password)
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 46)
            
            MainButton(text: "로그인", enable: loginViewModel.checkInput()) {
                // login process
            }
            .padding(.top, 40)
            .padding(.bottom, 10)
            
            HStack {
                Text("새로 가입할래요!")
                    .font(.haruchi(.button12))
                    .foregroundStyle(Color.gray5)
                
                Button {
                    // go signInView
                } label: {
                    Text("회원가입")
                        .font(.haruchi(.button12))
                        .foregroundStyle(Color.gray7)
                        .underline()
                }
            }
        }
    }
}


#Preview {
    LoginView()
}

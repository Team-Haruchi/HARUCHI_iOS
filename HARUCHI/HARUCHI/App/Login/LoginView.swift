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
    @ObservedObject private var loginViewModel: LoginViewModel
    @FocusState private var focusedField: LoginTextFieldType?
    
    init(appState: AppState) {
        self.loginViewModel = LoginViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack {
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
                    loginViewModel.login()
                }
                .padding(.top, 40)
                .padding(.bottom, 10)
                
                HStack {
                    Text("새로 가입할래요!")
                        .font(.haruchi(.button12))
                        .foregroundStyle(Color.gray5)
                    
                    Button {
                        loginViewModel.showSignInView = true
                    } label: {
                        Text("회원가입")
                            .font(.haruchi(.button12))
                            .foregroundStyle(Color.gray7)
                            .underline()
                    }
                }
            }
            
            if loginViewModel.isLoading {
                LoadingView()
            }
        }
        .alert(isPresented: $loginViewModel.showErrorAlert) {
            Alert(
                title: Text("로그인 실패"),
                message: Text("이메일과 비밀번호를 다시 한 번 확인해 주세요."),
                dismissButton: .default(Text("확인"))
            )
        }
        .navigationDestination(isPresented: $loginViewModel.showSignInView) {
            SignInView()
        }
    }
}

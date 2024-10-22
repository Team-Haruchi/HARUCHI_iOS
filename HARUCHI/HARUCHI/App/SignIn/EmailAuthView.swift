//
//  EmailAuthView.swift
//  HARUCHI
//
//  Created by 이건우 on 8/4/24.
//

import SwiftUI

struct EmailAuthView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Image("circleLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 35)
            
            Group {
                HStack(spacing: 0) {
                    Text("인증번호 확인")
                        .font(.haruchi(.button12))
                        .foregroundStyle(.black)
                        .padding(.trailing, 15)
                    
                    if !viewModel.authCodeVerified {
                        Text("인증번호를 보내드렸어요. (\(viewModel.formattedTime))")
                            .font(.haruchi(.button12))
                            .foregroundStyle(Color.haruchiRed)
                    } else {
                        Text("인증이 성공적으로 완료되었어요")
                            .font(.haruchi(.button12))
                            .foregroundStyle(Color.mainBlue)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.emailAuthProcess()
                        viewModel.startTimer()
                    } label: {
                        VStack(spacing: 0) {
                            Text("재요청")
                                .font(.haruchi(size: 10, family: .Regular))
                                .foregroundStyle(Color.gray5)
                            
                            GrayLine()
                                .frame(width: 25)
                        }
                    }
                    .disabled(viewModel.authCodeVerified)
                }
                .padding(.bottom, 35)
                
                HStack {
                    TextField("인증번호를 입력해주세요.", text: $viewModel.emailAuthCode)
                        .font(.haruchi(.button12))
                        .frame(height: 25)
                        .keyboardType(.numberPad)
                    
                    Button {
                        viewModel.verifyEmailAuthCode()
                    } label: {
                        Text("인증하기")
                            .font(.haruchi(size: 10, family: .Regular))
                            .foregroundStyle(viewModel.authCodeVerified ? Color.mainBlue : Color.gray5)
                            .frame(width: 65, height: 25)
                            .border(viewModel.authCodeVerified ? Color.mainBlue : Color.gray3)
                    }
                    .disabled(viewModel.timeRemaining == .zero)
                }
                .padding(.bottom, 10)
                
                GrayLine()
                    .padding(.bottom, 10)
                
                if viewModel.timeRemaining == .zero {
                    Text("인증시간이 만료되었습니다. “재요청” 버튼을 눌러주세요.")
                        .font(.haruchi(size: 10, family: .Regular))
                        .foregroundStyle(Color.haruchiRed)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            MainButton(text: "가입하기", enable: viewModel.authCodeVerified) {
                viewModel.showOnboarding = true
            }
            .padding(.bottom, 17)
        }
        .navigationTitle("회원가입")
        .navigationBarBackButtonHidden(true)
        .disableAutocorrection(true)
        .backButtonStyle()
        .loadingOverlay(isLoading: $viewModel.isLoading)
        .onAppear {
            viewModel.startTimer()
        }
        .navigationDestination(isPresented: $viewModel.showOnboarding) {
            OnboardingBudgetView(email: viewModel.email, password: viewModel.password)
        }
        .alert(isPresented: $viewModel.showEmailAuthCodeError) {
            Alert(
                title: Text("인증 실패"),
                message: Text("인증번호가 올바르지 않습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

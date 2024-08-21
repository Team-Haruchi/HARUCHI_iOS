//
//  OnboardingNicknameView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/22/24.
//

import SwiftUI

struct OnboardingNicknameView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("가입을 축하드려요!")
                Text("어떻게 불러드리면 될까요?")
            }
            .font(.haruchi(.h1))
            .foregroundColor(Color.black)
            .padding(.top, 70)
            .padding(.bottom, 150)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                HStack(alignment: .center) {
                    TextField("(한글) 5글자 내로 입력해주세요.", text: $viewModel.nickname)
                        .font(.haruchi(.h2))
                        .keyboardType(.default)
                    
                    Text("\(viewModel.nickname.count)/\(viewModel.maxLength)")
                        .font(.haruchi(.h2))
                        .foregroundColor(viewModel.nickname.isEmpty ? Color.gray : (viewModel.nicknameStatus == .invalid ? Color.red : Color.black))
                }
                
                HStack {
                    if viewModel.nicknameStatus == .invalid && !viewModel.nickname.isEmpty {
                        Text("올바르지 않은 형식입니다.")
                            .font(.haruchi(.caption3))
                            .foregroundColor(Color.red)
                    } else {
                        Text("")
                    }
                    
                    Spacer()
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .loadingOverlay(isLoading: $viewModel.isLoading)
        .backButtonStyle()
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                KeypadButton(text: "가입완료", enable: viewModel.nicknameStatus == .valid && viewModel.nickname.count <= viewModel.maxLength) {
                    
                    viewModel.signIn()
                }
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("회원가입 실패"),
                message: Text("문제가 발생했습니다, 관리자에게 문의하세요."),
                dismissButton: .default(Text("확인"))
            )
        }
        .alert(isPresented: $viewModel.goToLoginAlert) {
            Alert(
                title: Text("회원가입 성공"),
                message: Text("가입하신 계정으로 로그인을 진행해주세요."),
                dismissButton: .default(Text("확인"), action: {
                    appState.path = .init()
                })
            )
        }
    }
}

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
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("가입을 축하드려요!")
                        .padding(.bottom, 7)
                    Text("어떻게 불러드리면 될까요?")
                }
                .font(.haruchi(.h1))
                .foregroundColor(Color.black)
                .frame(width: 253, height: 64)
                .padding(.top, 124)
                .padding(.bottom, 150)
                .padding(.leading, 24)
                .padding(.trailing, 25)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        ZStack(alignment: .trailing) {
                            TextField("(한글) 5글자 내로 입력해주세요.", text: $viewModel.nickname)
                                .font(.haruchi(.h2))
                                .foregroundColor(viewModel.nicknameStatus == .invalid ? Color.black : Color.red)
                                .keyboardType(.default)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 24)
                            
                            Text("\(viewModel.nickname.count)/\(viewModel.maxLength)")
                                .font(.haruchi(.h2))
                                .foregroundColor(viewModel.nickname.isEmpty ? Color.gray : (viewModel.nicknameStatus == .invalid ? Color.red : Color.black))
                                .padding(.leading, 56)
                        }
                        .padding(.vertical, 5)
                    }
                    .padding(.trailing, 24)
                    
                    HStack {
                        if viewModel.nicknameStatus == .invalid && !viewModel.nickname.isEmpty {
                            Text("올바르지 않은 형식입니다.")
                                .font(.haruchi(.caption3))
                                .foregroundColor(Color.red)
                        } else {
                            Text(" ")
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 4)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                }
                .padding(.top, 30)
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
        .loadingOverlay(isLoading: $viewModel.isLoading)
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

//
//  EmailAuthView.swift
//  HARUCHI
//
//  Created by 이건우 on 8/4/24.
//

import SwiftUI

struct EmailAuthView: View {
    
    @EnvironmentObject var viewModel: SignInViewModel
    
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
                    
                    Text("인증번호를 보내드렸어요. (\(viewModel.formattedTime))")
                        .font(.haruchi(.button12))
                        .foregroundStyle(Color.haruchiRed)
                    
                    Spacer()
                    
                    Button {
                        // re request
                    } label: {
                        VStack(spacing: 0) {
                            Text("재요청")
                                .font(.haruchi(size: 10, family: .Regular))
                                .foregroundStyle(Color.gray5)
                            
                            GrayLine()
                                .frame(width: 25)
                        }
                    }
                    
                }
                .padding(.bottom, 35)
                
                HStack {
                    TextField("인증번호를 입력해주세요.", text: $viewModel.emailAuthCode)
                        .font(.haruchi(.button12))
                        .frame(height: 25)
                        .keyboardType(.numberPad)
                    
                    Button {
                        // authentication
                    } label: {
                        Text("인증하기")
                            .font(.haruchi(size: 10, family: .Regular))
                            .foregroundStyle(Color.gray5) // 색 분기처리
                            .frame(width: 65, height: 25)
                            .border(Color.gray3)
                    }
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
        }
        .navigationTitle("회원가입")
        .navigationBarBackButtonHidden(true)
        .disableAutocorrection(true)
        .backButtonStyle()
        .onAppear {
            viewModel.startTimer()
        }
    }
}

//
//  OnboardingView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/21/24.
//

import SwiftUI

struct OnboardingBudgetView: View {
    @ObservedObject private var viewModel: OnboardingViewModel
    
    init(
        email: String,
        password: String
    ) {
        self.viewModel = OnboardingViewModel(email: email, password: password)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("한 달 예산을 정해볼까요?")
                    .font(.haruchi(.h1))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 14)
                
                Text("예산을 설정하고 계획적으로 관리해보세요.")
                    .font(.haruchi(.button12))
                    .foregroundColor(.gray7)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 70)
            .padding(.horizontal, 24)
            
            HStack(spacing: 0) {
                Text("한 달 예산")
                    .font(.haruchi(.body_r16))
                    .padding(.vertical, 5)
                
                TextField("0", text: $viewModel.monthBudget)
                    .font(.haruchi(.h2))
                    .foregroundColor(.gray6)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                    .padding(.vertical, 5)
                
                Text("원")
                    .font(.haruchi(.h2))
                    .foregroundColor(.gray6)
                    .padding(.leading, 8)
                    .padding(.vertical, 5)
            }
            .overlay(
                Rectangle()
                    .foregroundColor(Color.gray5)
                    .frame(height: 1)
                    .padding(.top, 7)
                , alignment: .bottom
            )
            .frame(height: 32)
            .padding(.top, 185)
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                KeypadButton(
                    text: "다음", enable: !viewModel.monthBudget.isEmpty, action: { viewModel.showOnboardingNicknameView = true }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.showOnboardingNicknameView) {
            OnboardingNicknameView(viewModel: viewModel)
        }
    }
}

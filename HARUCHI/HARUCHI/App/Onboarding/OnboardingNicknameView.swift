//
//  OnboardingNicknameView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/22/24.
//

import SwiftUI

struct OnboardingNicknameView: View {
    @ObservedObject private var viewModel = OnboardingViewModel()

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
                            TextField("(한글) 5글자 내로 입력해주세요.", text: $viewModel.text)
                                .font(.haruchi(.h2))
                                .foregroundColor(viewModel.limitLength == .invalid ? Color.black : Color.red)
                                .keyboardType(.default)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 24)
                            
                            Text("\(viewModel.text.count)/\(viewModel.maxLength)")
                                .font(.haruchi(.h2))
                                .foregroundColor(viewModel.text.isEmpty ? Color.gray : (viewModel.limitLength == .invalid ? Color.red : Color.black))
                                .padding(.leading, 56)
                        }
                        .padding(.vertical, 5)
                    }
                    .padding(.trailing, 24)
                    
                    HStack {
                        if viewModel.limitLength == .invalid && !viewModel.text.isEmpty {
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
            
            NavigationLink(value: true) {
                EmptyView()
            }
            .navigationDestination(isPresented: $viewModel.isNavigationActive) {
                ContentView().navigationBarBackButtonHidden(true)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .ignoresSafeArea(.keyboard)
        
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                KeypadButton(text: "가입완료", enable: viewModel.limitLength == .valid && viewModel.text.count <= viewModel.maxLength) {
                    viewModel.isNavigationActive = true
                }
            }
        }
    }
}

#Preview {
    OnboardingNicknameView()
}

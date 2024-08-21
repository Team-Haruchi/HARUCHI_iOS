//
//  SignInView.swift
//  HARUCHI
//
//  Created by 이건우 on 7/21/24.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = SignInViewModel()
    @FocusState private var focusedField: SignInTextFieldType?
    
    var seeTermInfo: some View {
        VStack(spacing: 3) {
            Text("내용 보기")
                .font(.haruchi(size: 10, family: .Regular))
            
            Rectangle()
                .frame(height: 1)
        }
        .frame(width: 40)
        .foregroundStyle(Color.sub2Blue)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
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
                    
                    Group {
                        Text("이메일")
                            .font(.haruchi(.button12))
                            .padding(.top, 25)
                            .padding(.bottom, 15)
                        
                        TextField("이메일을 입력해주세요.", text: $viewModel.email)
                            .font(.haruchi(.button12))
                            .padding(.bottom, 5)
                            .keyboardType(.alphabet)
                            .focused($focusedField, equals: .email)
                        
                        GrayLine()
                            .padding(.bottom, 8)
                        
                        Text(viewModel.validationStatus[.email] == false ? "올바르지 않은 형식입니다." : "")
                            .font(.haruchi(size: 10, family: .Regular))
                            .foregroundColor(.red)
                            .frame(height: 20)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    
                    
                    Group {
                        Text("비밀번호")
                            .font(.haruchi(.button12))
                            .padding(.vertical, 15)
                        
                        SecureField("영어, 숫자, 특수문자 조합 8~30자리", text: $viewModel.password)
                            .font(.haruchi(.button12))
                            .padding(.bottom, 5)
                            .focused($focusedField, equals: .password)
                        
                        GrayLine()
                            .padding(.bottom, 8)
                        
                        Text(viewModel.validationStatus[.password] == false ? "비밀번호는 영어, 숫자, 특수문자 조합 8~30자리이어야 합니다." : "")
                            .font(.haruchi(size: 10, family: .Regular))
                            .foregroundColor(.red)
                            .frame(height: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    
                    
                    Group {
                        Text("비밀번호 확인")
                            .font(.haruchi(.button12))
                            .padding(.vertical, 15)
                        
                        SecureField("비밀번호를 확인해주세요.", text: $viewModel.passwordValid)
                            .font(.haruchi(.button12))
                            .padding(.bottom, 5)
                            .focused($focusedField, equals: .passwordValid)
                        
                        GrayLine()
                            .padding(.bottom, 8)
                        
                        Text(viewModel.validationStatus[.passwordValid] == false ? "비밀번호가 일치하지 않습니다." : "")
                            .font(.haruchi(size: 10, family: .Regular))
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    Group {
                        Text("약관 동의")
                            .font(.haruchi(.button12))
                            .padding(.bottom, 15)
                        
                        Button {
                            viewModel.agreeAllTapped()
                        } label: {
                            HStack(spacing: 5) {
                                Image(viewModel.termAgree && viewModel.collectInfoAgree ? "signIn_checkBoxSelected" : "signIn_checkBoxUnselected")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text("전체 동의합니다.")
                                    .font(.haruchi(.button14))
                            }
                        }
                        
                        GrayLine()
                            .padding(.vertical, 8)
                        
                        Button {
                            viewModel.termAgree.toggle()
                        } label: {
                            HStack(spacing: 5) {
                                Image(viewModel.termAgree ? "signIn_checkBoxSelected" : "signIn_checkBoxUnselected")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text("이용약관에 동의합니다. (필수)")
                                    .font(.haruchi(.button12))
                                
                                Spacer()
                                
                                Button {
                                    viewModel.showTermAgreeLink = true
                                } label: {
                                    seeTermInfo
                                }
                            }
                            .padding(.bottom, 8)
                        }

                        Button {
                            viewModel.collectInfoAgree.toggle()
                        } label: {
                            HStack(spacing: 3) {
                                Image(viewModel.collectInfoAgree ? "signIn_checkBoxSelected" : "signIn_checkBoxUnselected")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text("개인정보 수집 및 이용에 동의합니다. (필수)")
                                    .font(.haruchi(.button12))
                                
                                Spacer()
                                
                                Button {
                                    viewModel.showTermAgreeLink = true
                                } label: {
                                    seeTermInfo
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    
                    
                    MainButton(text: "인증번호 받기", enable: viewModel.canGoNext) {
                        viewModel.emailAuthProcess()
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 18)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard){
                HStack(spacing: 0) {
                    Button(action: focusPreviousField) {
                        Image(systemName: "chevron.up").tint(.black)
                    }
                    .disabled(!canFocusPreviousField())
                    
                    Button(action: focusNextField) {
                        Image(systemName: "chevron.down").tint(.black)
                    }
                    .disabled(!canFocusNextField())
                    
                    Spacer()
                    
                    Button {
                        focusedField = nil
                    } label: {
                        Text("완료")
                            .font(.haruchi(.button16))
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
        .backButtonStyle()
        .loadingOverlay(isLoading: $viewModel.isLoading)
        .navigationTitle("회원가입")
        .navigationBarBackButtonHidden(true)
        .disableAutocorrection(true)
        .navigationDestination(isPresented: $viewModel.showEmailAuthView) {
            EmailAuthView(viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.showEmailDuplicateError) {
            Alert(
                title: Text("회원가입 실패"),
                message: Text("이미 존재하는 이메일입니다."),
                dismissButton: .default(Text("확인"))
            )
        }
        .fullScreenCover(isPresented: $viewModel.showTermAgreeLink) {
            if let url = viewModel.termAgreeLinkURL {
                SafariView(url: url)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showcollectInfoAgreeLink) {
            if let url = viewModel.showcollectInfoAgreeLinkURL {
                SafariView(url: url)
            }
        }
    }
}

extension SignInView {
    private func focusPreviousField() {
        focusedField = focusedField.map {
            SignInTextFieldType(rawValue: $0.rawValue - 1) ?? .passwordValid
        }
    }

    private func focusNextField() {
        focusedField = focusedField.map {
            SignInTextFieldType(rawValue: $0.rawValue + 1) ?? .email
        }
    }
    
    private func canFocusPreviousField() -> Bool {
        guard let currentFocusedField = focusedField else {
            return false
        }
        return currentFocusedField.rawValue > 0
    }

    private func canFocusNextField() -> Bool {
        guard let currentFocusedField = focusedField else {
            return false
        }
        return currentFocusedField.rawValue < SignInTextFieldType.allCases.count - 1
    }
}

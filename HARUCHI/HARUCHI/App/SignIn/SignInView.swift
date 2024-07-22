//
//  SignInView.swift
//  HARUCHI
//
//  Created by 이건우 on 7/21/24.
//

import SwiftUI

struct SignInView: View {
    
    @FocusState private var focusedField: Field?
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordValid: String = ""
    
    @State private var validationStatus: [Field: Bool] = [
        .email: true,
        .password: true,
        .passwordValid: true
    ]
    
    // 이메일 정규식
    private func checkEmailForm(input: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input)
    }
    
    // 영어, 숫자, 특수문자 조합 8~30자 정규식
    private func checkPasswordForm(input: String) -> Bool {
        let pwRegex = "(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}"
        return NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: input)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image("signIn_circleLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                .padding(.top, 35)
                
                Group {
                    Text("이메일")
                        .font(.haruchi(.button12))
                        .padding(.top, 25)
                        .padding(.bottom, 15)
                    
                    TextField("이메일을 입력해주세요.", text: $email)
                        .font(.haruchi(.button12))
                        .padding(.bottom, 5)
                        .keyboardType(.alphabet)
                        .focused($focusedField, equals: .email)
                        .onChange(of: email) {
                            validationStatus[.email] = checkEmailForm(input: email)
                        }
                        .overlay {
                            
                        }
                    
                    GrayLine()
                        .padding(.bottom, 8)
                    
                    Text(validationStatus[.email]! ? "" : "올바르지 않은 형식입니다.")
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
                    
                    SecureField("영어, 숫자, 특수문자 조합 8~30자리", text: $password)
                        .font(.haruchi(.button12))
                        .padding(.bottom, 5)
                        .focused($focusedField, equals: .password)
                        .onChange(of: password) {
                            validationStatus[.password] = checkPasswordForm(input: password)
                        }
                    
                    GrayLine()
                        .padding(.bottom, 8)
                    
                    Text(validationStatus[.password]! ? "" : "비밀번호는 영어, 숫자, 특수문자 조합 8~30자리이어야 합니다.")
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
                    
                    SecureField("비밀번호를 확인해주세요.", text: $passwordValid)
                        .font(.haruchi(.button12))
                        .padding(.bottom, 5)
                        .focused($focusedField, equals: .passwordValid)
                        .onChange(of: passwordValid) {
                            validationStatus[.passwordValid] = (passwordValid == password)
                        }
                    
                    GrayLine()
                        .padding(.bottom, 8)
                    
                    Text(validationStatus[.passwordValid]! ? "" : "비밀번호가 일치하지 않습니다.")
                        .font(.haruchi(size: 10, family: .Regular))
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                
                Spacer()
                                
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
        .navigationTitle("회원가입")
        .navigationBarBackButtonHidden(true)
        .disableAutocorrection(true)
        .backButtonStyle()
    }
}

extension SignInView {
    enum Field: Int, CaseIterable {
        case email
        case password
        case passwordValid
    }
    
    private func focusPreviousField() {
        focusedField = focusedField.map {
            Field(rawValue: $0.rawValue - 1) ?? .passwordValid
        }
    }

    private func focusNextField() {
        focusedField = focusedField.map {
            Field(rawValue: $0.rawValue + 1) ?? .email
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
        return currentFocusedField.rawValue < Field.allCases.count - 1
    }
}

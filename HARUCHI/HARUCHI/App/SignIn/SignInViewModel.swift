//
//  SignInViewModel.swift
//  HARUCHI
//
//  Created by 이건우 on 7/22/24.
//

import Foundation
import Combine

enum SignInTextFieldType: Int, CaseIterable {
    case email
    case password
    case passwordValid
}

class SignInViewModel: ObservableObject {
    
    // 인증번호 요청 가능 여부 (사용자 정보값 validation 및 약관 동의 여부)
    @Published var canGoNext: Bool = false
    @Published var showEmailAuthView: Bool = false
    
    @Published var timeRemaining: Int = 120 // 이메일 인증시간 (2분)
    @Published var formattedTime: String = "2분00초"
    
    // MARK: - SignIn
    @Published var email: String = "" {
        didSet {
            if email != oldValue { validateEmail() }
        }
    }
    @Published var password: String = "" {
        didSet {
            if password != oldValue { validatePassword() }
        }
    }
    @Published var passwordValid: String = "" {
        didSet {
            if passwordValid != oldValue { validatePasswordValid() }
        }
    }
    
    @Published var validationStatus: [SignInTextFieldType: Bool] = [
        .email: true,
        .password: true,
        .passwordValid: true
    ]
    
    @Published var termAgree: Bool = false
    @Published var collectInfoAgree: Bool = false
    
    private var timer: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    private let authService = AuthService()
    
    init() {
        setupCanGoNextPublisher()
    }
    
    private func setupCanGoNextPublisher() {
        Publishers.CombineLatest3(
            $validationStatus.map { $0.values.allSatisfy { $0 } },
            $termAgree,
            $collectInfoAgree
        )
        .map { $0 && $1 && $2 }
        .assign(to: \.canGoNext, on: self)
        .store(in: &cancellables)
    }
    
    func agreeAllTapped() {
        if termAgree && collectInfoAgree {
            termAgree = false
            collectInfoAgree = false
        } else {
            termAgree = true
            collectInfoAgree = true
        }
    }
    
    private func validateEmail() {
        validationStatus[.email] = checkEmailForm(input: email)
    }
    
    private func validatePassword() {
        validationStatus[.password] = checkPasswordForm(input: password)
    }
    
    private func validatePasswordValid() {
        validationStatus[.passwordValid] = (passwordValid == password)
    }
    
    private func checkEmailForm(input: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input)
    }
    
    // 영어, 숫자, 특수문자 조합 8~30자 정규식
    private func checkPasswordForm(input: String) -> Bool {
        let pwRegex = "(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}"
        return NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: input)
    }
    
    // MARK: - Email Auth
    @Published var emailAuthCode: String = ""
    @Published var showEmailDuplicateError: Bool = false
    @Published var showEmailAuthCodeError: Bool = false
    @Published var isLoading: Bool = false
    @Published var authCodeVerified: Bool = false
    @Published var showOnboarding: Bool = false
    
    func emailAuthProcess() {
        isLoading = true
        
        authService.requestEmailAuthCode(for: email)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.emailAuthCodeRequestFail()
                }
            } receiveValue: { [weak self] response in
                if response.isSuccess {
                    self?.emailAuthCodeRequestSuccess()
                }
            }
            .store(in: &cancellables)
    }
    
    func verifyEmailAuthCode() {
        isLoading = true
        
        authService.verifyEmailAuthCode(email: email, code: emailAuthCode)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.verifyEmailAuthCodeFail()
                }
            } receiveValue: { [weak self] response in
                if response.isSuccess {
                    self?.verifyEmailAuthCodeSuccess()
                }
            }
            .store(in: &cancellables)
    }
    
    private func emailAuthCodeRequestFail() {
        isLoading = false
        showEmailDuplicateError = true
    }
    
    private func emailAuthCodeRequestSuccess() {
        isLoading = false
        showEmailAuthView = true
    }
    
    private func verifyEmailAuthCodeFail() {
        isLoading = false
        showEmailAuthCodeError = true
    }
    
    private func verifyEmailAuthCodeSuccess() {
        isLoading = false
        authCodeVerified = true
    }
    
    func startTimer() {
        timer?.cancel() // 기존 타이머 취소
        timeRemaining = 120 // 타이머 초기화
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    private func updateFormattedTime() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        if minutes > 0 {
            formattedTime = String(format: "%01d분 %01d초", minutes, seconds)
        } else {
            formattedTime = String(format: "%01d초", seconds)
        }
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateFormattedTime()
        } else {
            timer?.cancel()
        }
    }
    
    deinit {
        timer?.cancel() // 뷰 모델 해제 시 타이머 취소
    }
}

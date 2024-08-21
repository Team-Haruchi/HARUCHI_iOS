//
//  OnboardingNicknameViewModel.swift
//  HARUCHI
//
//  Created by 채리원 on 7/23/24.
//

import SwiftUI
import Combine

enum TextLengthStatus {
    case valid
    case invalid
    case `default`
}

class OnboardingViewModel: ObservableObject {
    @Published var monthBudget = ""
    @Published var nickname = ""
    @Published var showOnboardingNicknameView: Bool = false
    @Published var nicknameStatus: TextLengthStatus = .default
    @Published var isLoading: Bool = false
    
    @Published var showErrorAlert: Bool = false
    @Published var goToLoginAlert: Bool = false
    
    private var email: String
    private var password: String
    private var cancellables = Set<AnyCancellable>()
    private let authService = AuthService()
    let maxLength = 5
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        
        sinkNickname()
    }
    
    func signIn() {
        isLoading = true
        
        authService.requestSignIn(
            email: email,
            password: password,
            monthBudget: Int(monthBudget)!,
            name: nickname
        )
        .sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
                self.signInFail()
            }
        } receiveValue: { [weak self] response in
            if response.isSuccess {
                self?.signInSuccess()
            }
        }
        .store(in: &cancellables)
    }
    
    private func signInFail() {
        isLoading = false
        showErrorAlert = true
    }
    
    private func signInSuccess() {
        isLoading = false
        goToLoginAlert = true
    }
    
    private func sinkNickname() {
        $nickname
            .sink { [weak self] newValue in
                self?.validateAndLimitText()
            }
            .store(in: &cancellables)
    }
    
    private func validateAndLimitText() {
        if nickname.count > maxLength || nickname.isEmpty || !validateNickname(nickname) {
            nicknameStatus = .invalid
        } else {
            nicknameStatus = .valid
        }
    }

    private func validateNickname(_ input: String) -> Bool {
        let pattern = "^[가-힣]*$"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: input.utf16.count)
            return regex.firstMatch(in: input, options: [], range: range) != nil
        }
        return false
    }
}

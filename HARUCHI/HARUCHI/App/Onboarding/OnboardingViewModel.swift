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
    @Published var budget: String = "0" // 예산값 저장
    @Published var nicknameStatus: TextLengthStatus = .default
    
    private var cancellables = Set<AnyCancellable>()
    let maxLength = 5
    
    init() {
        sinkNickname()
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

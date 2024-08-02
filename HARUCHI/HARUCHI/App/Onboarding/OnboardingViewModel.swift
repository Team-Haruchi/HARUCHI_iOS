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
    @Published var text = ""
    @Published var isNavigationActive: Bool = false
    @Published var budget: String = "0" // 예산값 저장
    @Published var limitLength: TextLengthStatus = .default
    
    let maxLength = 5

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $text
            .sink { [weak self] newValue in
                self?.validateAndLimitText()
            }
            .store(in: &cancellables)
    }
    
    func validateAndLimitText() {
        if text.count > maxLength || text.isEmpty || !isKoreanOnly(text) {
            limitLength = .invalid
        } else {
            limitLength = .valid
        }
    }

    private func isKoreanOnly(_ input: String) -> Bool {
        let pattern = "^[가-힣]*$"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: input.utf16.count)
            return regex.firstMatch(in: input, options: [], range: range) != nil
        }
        return false
    }
}

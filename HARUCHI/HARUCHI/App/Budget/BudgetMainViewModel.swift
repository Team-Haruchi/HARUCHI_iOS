//
//  BudgetMainViewModel.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/24/24.
//

import SwiftUI

import Combine
import Moya

enum Budget {
    enum Push: String {
        case safebox = "세이프박스"
        case split = "고르게 넘기기"
    }
    
    enum Pull: String {
        case safebox = "세이프박스"
        case split = "고르게 당겨쓰기"
    }
}

class BudgetMainViewModel: ObservableObject {
    @Published var isPushButtonActive: Bool = false
    @Published var isBoxButtonActive: Bool = false
    @Published var money = ""
    
    @Published var dayBudget: Int = 0
    @Published var safeBox: Int = 0
    
    @Published var accessToken: String
    @Published var errorMessage: String?
    
    @Published var pushMethod: Budget.Push?
    @Published var pullMethod: Budget.Pull?
    
    @Published var showOverlayPush = false //넘기기 옵션선택
    @Published var showOverlayPull = false //당겨쓰기 옵션 선택
    
    private var cancellables = Set<AnyCancellable>()
    private let budgetService = BudgetService()
    
    init(
        accessToken: String = ""
    ) {
        self.accessToken = accessToken
    }
    
    func loadBudget(accessToken: String) {
        budgetService.fetchBudget(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load budget: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { budgetResponse in
                self.dayBudget = budgetResponse.result.dayBudget
            })
            .store(in: &cancellables)
    }
    
    func loadSafeBox(accessToken: String) {
        budgetService.fetchSafeBox(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load SafeBox: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { safeBoxResponse in
                self.safeBox = safeBoxResponse.result.safeBox
            })
            .store(in: &cancellables)
    }
    
    
    
    
    
    func activeMethodStr() -> String {
        if isPushButtonActive {
            return pushMethod?.rawValue ?? "선택해주세요"
        } else {
            return pullMethod?.rawValue ?? "선택해주세요"
        }
    }
}

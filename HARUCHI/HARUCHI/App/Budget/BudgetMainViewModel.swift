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

enum PushOption: String {
    case date = "DATE"
    case safeBox = "SAFEBOX"
    case evenly = "EVENLY"
}

class BudgetMainViewModel: ObservableObject {
    @Published var isPushButtonActive: Bool = false
    @Published var isBoxButtonActive: Bool = false
    @Published var pullPushBudget = ""
    
    @Published var dayBudget: Int = 0
    @Published var safeBox: Int = 0
    
    @Published var errorMessage: String?
    
    @Published var pushMethod: Budget.Push?
    @Published var pullMethod: Budget.Pull?
    
    @Published var showOverlayPush = false //넘기기 옵션선택
    @Published var showOverlayPull = false //당겨쓰기 옵션 선택
    
    private var cancellables = Set<AnyCancellable>()
    private let budgetService = BudgetService()
    
    private var pushOption: PushOption?
    @Published var sourceDay: Int = 0
    @Published var targetDay: Int? = nil
    
    @Published var firstDate: Date = Date()
    @Published var secondDate: Date = Date()

    func refreshData() {
        pushMethod = .none
        pullMethod = .none
    }
    
    func dateToDay() {
        if pushMethod == .safebox || pushMethod == .split {
            let firstCalendar = Calendar.current
            self.sourceDay = firstCalendar.component(.day, from: firstDate)
            print("targetDay: ", targetDay)
            print("sourceDay: ", sourceDay)
        } else {
            // Calendar 객체를 통해 날짜의 일(day) 부분을 추출
            let firstCalendar = Calendar.current
            self.sourceDay = firstCalendar.component(.day, from: firstDate)
            let secondCalendar = Calendar.current
            self.targetDay = secondCalendar.component(.day, from: secondDate)
        }
    }
    
    func loadBudget() {
        budgetService.fetchBudget()
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
    
    func loadSafeBox() {
        budgetService.fetchSafeBox()
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
    
    func ChoosePushOption() {
        switch pushMethod {
        case .safebox:
            pushOption = .safeBox
            targetDay = nil
        case .split:
            pushOption = .evenly
            targetDay = nil
        case .none:
            pushOption = .date
        }
    }
    
    func pushBudget() {
        ChoosePushOption()
        dateToDay()
        let option = pushOption?.rawValue ?? "EVENLY"
        let amount = Int(pullPushBudget)!
        let target: Int? = targetDay != nil ? targetDay : nil
        let source = sourceDay
        print("옵션: \(option),날짜1: \(source),날짜2: \(String(describing: target)),금액: \(amount)")
        budgetService.requestPushBudget(
            redistributionOption: option,
            amount: amount,
            sourceDay: source,
            targetDay: target
        )
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to Push Budget: \(error.localizedDescription)"
                    print("errorMessage: \(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { pushBudgetResponse in

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

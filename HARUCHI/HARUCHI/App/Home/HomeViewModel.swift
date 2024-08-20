//
//  HomeViewModel.swift
//  HARUCHI
//
//  Created by 채리원 on 7/31/24.
//

import SwiftUI
import Combine


class HomeViewModel: ObservableObject {
    @Published var currentMonth: String = ""
    @Published var money = ""
    @Published var budget: String = "0"
    @Published var selectedType: String = "미분류"
    @Published var selectedCategory: String = "미분류"
    @Published var selectedIncome: String = "미분류"
    @Published var showIncomeSheet: Bool = false
    @Published var upSpendSheet: Bool = false
    @Published var navigateToReceipt: Bool = false
    @Published var navigateToHomeMain: Bool = false
    @Published var showMainButton: Bool = false
    @Published var weekData: [WeekCalendarModel] = []
        
    @Published var accessToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MTgsImVtYWlsIjoidGVzdHl1cEB0ZXN0LmNvbSIsImlhdCI6MTcyMzc4MjI1MX0.RQYp5-xAV3NOmvLIMcyOrR_HUSoT_nd-URntobYOymg"
    @Published var errorMessage: String?
    @Published var monthBudget: Int = 0
    @Published var leftDay: Int = 0
    @Published var leftBudget: Int = 0
    @Published var monthUsedPercent: Int = 0
    @Published var weekBudget: Int = 0
    @Published var weekDay: Int = 0
    @Published var weekStatus: String = ""
    
    
    
    private var cancellables = Set<AnyCancellable>()
    private let budgetService = BudgetService()
    
    var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    init(
        accessToken: String = ""
    ) {
        updateCurrentMonth()
        self.accessToken = accessToken
    }
    
    func loadMonthBudget(accessToken: String) {
        budgetService.fetchMonthBudget(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load MonthBudget: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { monthBudgetResponse in
                self.monthBudget = monthBudgetResponse.result.monthBudget
            })
            .store(in: &cancellables)
    }
    
    func loadLeftNow(accessToken: String) {
        budgetService.fetchLeftNow(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load LeftNow: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { leftNowResponse in
                self.leftDay = leftNowResponse.result.leftDay
                self.leftBudget = leftNowResponse.result.leftBudget
            })
            .store(in: &cancellables)
    }
    
    func loadBudgetPercent(accessToken: String) {
        budgetService.fetchBudgetPercent(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load BudgetPercent: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { budgetPercentResponse in
                self.monthUsedPercent = budgetPercentResponse.result.monthUsedPercent
            })
            .store(in: &cancellables)
    }
    
    func loadWeekBudget(accessToken: String) {
        budgetService.fetchWeekBudget(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load WeekBudget: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { [weak self] weekBudgetResponse in
                guard let self = self else { return }
                
                // weekBudgetResponse에서 데이터를 추출하여 setupCalendarData로 전달
                let weekBudgets = weekBudgetResponse.result.weekBudget
                self.setupCalendarData(with: weekBudgets)
            })
            .store(in: &cancellables)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func setupCalendarData(with weekBudgets: [WeekBudgetItem]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        // 현재 날짜, 현재 주의 시작일과 종료일 계산
        let calendar = Calendar.current
        let today = Date()
        
        // 한주 시작 월요일로 설정
        let startOfWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        guard let startDate = calendar.date(from: startOfWeek) else { return }
        
        // 주간 데이터 배열 생성
        var weekData = [WeekCalendarModel]()
        
        // 일주일 동안 날짜를 생성, 데이터 추가
        for dayOffset in 0..<8 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) {
                // 해당 날짜의 예산 데이터를 찾음
                let day = calendar.component(.day, from: date)
                if let budgetForDay = weekBudgets.first(where: { $0.day == day }) {
                    let iconName = ["calendar_smiling", "calendar_pouting", "calendar_base"].randomElement() ?? "calendar_base"
                    let value = budgetForDay.dayBudget
                    
                    let model = WeekCalendarModel(date: date, icon: iconName, value: value)
                    weekData.append(model)
                } else {
                    // 해당 날짜에 데이터가 없을 경우 기본값으로 처리
                    let model = WeekCalendarModel(date: date, icon: "calendar_base", value: 0)
                    weekData.append(model)
                }
            }
        }
        
        // weekData 업데이트 + 월 업데이트 같이
        self.weekData = weekData
        updateCurrentMonth()
    }
    
    func updateCurrentMonth() {
        let calendar = Calendar.current
        let today = Date()
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLLL"
        monthFormatter.locale = Locale(identifier: "ko_KR") // 한국어 
        self.currentMonth = monthFormatter.string(from: today)
    }
}

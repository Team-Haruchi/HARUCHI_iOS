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
    @Published var editedBudget: String = ""
    @Published var selectedType: String = "미분류"
    @Published var selectedCategory: String = "미분류"
    @Published var selectedIncome: String = "미분류"
    @Published var formattedDate: String = ""
    @Published var showIncomeSheet: Bool = false
    @Published var upSpendSheet: Bool = false
    @Published var navigateToReceipt: Bool = false
    @Published var navigateToHomeMain: Bool = false
    @Published var showMainButton: Bool = false
    @Published var weekData: [WeekCalendarModel] = []
    @Published var expenditureList: [ExpenditureResult] = []
        
    @Published var errorMessage: String?
    @Published var monthBudget: Int = 0
    @Published var leftDay: Int = 0
    @Published var leftBudget: Int = 0
    @Published var monthUsedPercent: Double = 0.0
    @Published var weekBudget: Int = 0
    @Published var weekDay: Int = 0
    @Published var weekStatus: String = ""
    
    @Published var closeAmountSuccess: Bool = false
    @Published var closeBudgetSuccess: Bool = false
    @Published var closeReceiptSuccess: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let budgetService = BudgetService()
    
    private let incomeService = IncomeService()
    private let expenditureService = ExpenditureService()
    private let closeService = CloseService()


    var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    init() {
        self.updateCurrentMonth()
    }
    
    func loadMonthBudget() {
        budgetService.fetchMonthBudget()
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
    
    func loadLeftNow() {
        budgetService.fetchLeftNow()
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
    
    func loadBudgetPercent() {
        budgetService.fetchBudgetPercent()
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
    
    func loadWeekBudget() {
        budgetService.fetchWeekBudget()
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
    
    func editMonthlyBudget() {
        budgetService.requestEditBudget(monthBudget: monthBudget)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to Edit Budget: \(error.localizedDescription)"
                    print("errorMessage: \(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { editBudgetResponse in
                print("success ID : \(editBudgetResponse.result.id)")
                print("변경된 예산: \(self.monthBudget)")


            })
            .store(in: &cancellables)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // 오늘 날짜 띄우는 함수
    func updateDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d일 EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let today = Date()
        self.formattedDate = dateFormatter.string(from: today)
    }
    
    func requestIncome() {
        guard let amount = Int(money), selectedCategory != "미분류" else {
            return
        }

        
        incomeService.requestIncome(incomeAmount: amount, category: selectedCategory)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("해당 수입이 존재하지 않습니다: \(error)")
                }
            }, receiveValue: { incomeResponse in
                print("수입이 성공적으로 등록되었습니다: \(incomeResponse)")
            })
            .store(in: &cancellables)
    }
    
    func reqeustExpenditure() {
        guard let amount = Int(money), selectedCategory != "미분류" else {
            return
        }
        
        
        expenditureService.requestExpenditure(expenditureAmount: amount, category: selectedCategory)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("해당 지출이 존재하지 않습니다: \(error)")
                }
            }, receiveValue: { expenditureResponse in
                print("지출이 성공적으로 등록되었습니다: \(expenditureResponse)")
            })
            .store(in: &cancellables)
    }
    
    func closeReceipt() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)

        closeService.closeReceipt(year: year, month: month, day: day)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "영수증 조회 불가: \(error.localizedDescription)"
                    print("errorMessage: \(String(describing: self.errorMessage))")
                }
            }, receiveValue: { closeResult in
                print("영수증 조회 성공: \(closeResult)")
                
                let result = closeResult.result
                
                if result.incomeList.isEmpty && result.expenditureList.isEmpty {
                    self.errorMessage = "해당 날짜에 수입 및 지출이 존재하지 않습니다."
                    print(self.errorMessage ?? "Unknown error")
                } else {
                    self.money = "\(result.dayBudget)"
                    self.expenditureList = result.expenditureList
                }
            })
            .store(in: &cancellables)
    }

    func closeBudget(redistributionOption: String, year: Int, month: Int, day: Int) {
        closeService.closeBudget(redistributionOption: redistributionOption, year: year, month: month, day: day)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.closeBudgetSuccess = true // UI can react to this
                case .failure(let error):
                    self.errorMessage = "지출 마감에 실패하셨습니다: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                    self.closeBudgetSuccess = false
                }
            }, receiveValue: { closeResult in
                print("지출 마감 성공: \(closeResult)")
            })
            .store(in: &cancellables)
    }

    func closeAmount(year: Int, month: Int, day: Int) {
        guard monthBudget > 0 else {
            self.errorMessage = "amount가 0일 때는 1/n을 할 수 없습니다"
            self.closeAmountSuccess = false
            return
        }
        
        closeService.closeAmount(year: year, month: month, day: day)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.closeAmountSuccess = true
                case .failure(let error):
                    self.errorMessage = "차감/분배 조회 실패: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                    self.closeAmountSuccess = false
                }
            }, receiveValue: { closeResult in
                print("차감/분배 조회 성공: \(closeResult)")
                // 여기서 받아온 데이터를 UI에 반영
                self.money = "\(closeResult.result.dayBudget)"
            })
            .store(in: &cancellables)
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
        _ = Calendar.current
        let today = Date()
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLLL"
        monthFormatter.locale = Locale(identifier: "ko_KR") // 한국어
        self.currentMonth = monthFormatter.string(from: today)
    }
}

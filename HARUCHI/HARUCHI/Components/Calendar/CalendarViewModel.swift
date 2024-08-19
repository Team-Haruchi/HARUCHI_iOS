import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var calendarData: [CalendarModel] = []
    @Published var firstSelectedDate: Date?
    @Published var secondSelectedDate: Date?
    @Published var currentMonth: Date = Date()
    
    @Published var formattedDate: String = ""
    
    @Published var dateBudget: Double = 30
    @Published var calendarDate: Int = 0
    @Published var accessToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MTgsImVtYWlsIjoidGVzdHl1cEB0ZXN0LmNvbSIsImlhdCI6MTcyMzc4MjI1MX0.RQYp5-xAV3NOmvLIMcyOrR_HUSoT_nd-URntobYOymg"
    @Published var errorMessage: String?
    
    private let budgetService = BudgetService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchCalendarData()
        setupBindings()
    }
    
    func loadDateBudget(accessToken: String) {
        budgetService.fetchDateBudget(accessToken: accessToken)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load dateBudget: \(error.localizedDescription)"
                    print("errorMessage:\(String(describing: self.errorMessage!))")
                }
            }, receiveValue: { dateBudgetResponse in
                self.dateBudget = dateBudgetResponse.result.budget[0].dayBudget
                self.calendarDate = dateBudgetResponse.result.budget[0].day
            })
            .store(in: &cancellables)
    }
    
    // 샘플 데이터를 생성하는 함수
    
//    func fetchCalendarData() {
//        loadDateBudget(accessToken: accessToken)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        print("\(dateBudget)")
//        
//         샘플 데이터 생성
//        calendarData = [
//            CalendarModel(date: dateFormatter.date(from: "2024-08-01")!, budget: dateBudget),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-02")!, budget: 2000000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-03")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-04")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-05")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-06")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-07")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-08")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-09")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-10")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-11")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-12")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-13")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-14")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-15")!, budget: 2000000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-16")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-17")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-18")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-19")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-20")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-21")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-22")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-23")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-24")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-25")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-26")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-27")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-28")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-29")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-30")!, budget: 20000),
//            CalendarModel(date: dateFormatter.date(from: "2024-08-31")!, budget: 20000),
//             ... 추가 데이터
//        ]
//    }
//    func fetchCalendarData() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        budgetService.fetchDateBudget(accessToken: accessToken)
//            .map { dateBudgetResponse in
//                dateBudgetResponse.result.budget[0].dayBudget
//            }
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.errorMessage = "Failed to load dateBudget: \(error.localizedDescription)"
//                }
//            }, receiveValue: { dayBudget in
//                self.dateBudget = dayBudget
//                print(self.dateBudget)
//                self.calendarData = [
//                    CalendarModel(date: dateFormatter.date(from: "\(self.todayDate)")!, budget: self.dateBudget),
//                    ]
//            })
//            .store(in: &cancellables)
//    }
    func fetchCalendarData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 오늘 날짜 가져오기
        let today = Date()
        
        // 오늘을 포함한 이번 달의 마지막 날짜 계산
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: today)!
        let lastDay = range.count
        let todayDay = calendar.component(.day, from: today)
        
        var dates: [Date] = []
        
        // 오늘부터 이번 달의 마지막 날짜까지 배열에 추가
        for day in todayDay...lastDay {
            if let date = calendar.date(bySetting: .day, value: day, of: today) {
                dates.append(date)
            }
        }
        
        // 캘린더 데이터 초기화
        self.calendarData = []
        
        // 예산 데이터 가져오기
        budgetService.fetchDateBudget(accessToken: accessToken)
            .map { dateBudgetResponse in
                dateBudgetResponse.result.budget
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load dateBudget: \(error.localizedDescription)"
                }
            }, receiveValue: { budgetData in
                // 날짜별 예산 데이터 매핑
                for budget in budgetData {
                    let day = budget.day
                    let dayBudget = budget.dayBudget
                    
                    if let date = calendar.date(bySetting: .day, value: day, of: today) {
                        self.calendarData.append(CalendarModel(date: date, budget: dayBudget))
                    }
                }
                
                // 캘린더 데이터 확인
                print(self.calendarData)
            })
            .store(in: &cancellables)
    }
    
    // Combine을 사용하여 선택 로직을 설정하는 함수
    private func setupBindings() {
        $firstSelectedDate
            .combineLatest($currentMonth)
            .sink { [weak self] firstSelectedDate, currentMonth in
                guard let self = self else { return }
                if let date = firstSelectedDate, !self.isDateInCurrentMonth(date, currentMonth: currentMonth) {
                    self.firstSelectedDate = nil
                }
            }
            .store(in: &cancellables)
        
        $secondSelectedDate
            .combineLatest($currentMonth)
            .sink { [weak self] secondSelectedDate, currentMonth in
                guard let self = self else { return }
                if let date = secondSelectedDate, !self.isDateInCurrentMonth(date, currentMonth: currentMonth) {
                    self.secondSelectedDate = nil
                }
            }
            .store(in: &cancellables)
    }

    // 특정 날짜의 예산을 반환하는 함수
    func budget(for date: Date) -> Double? {
        calendarData.first { Calendar.current.isDate($0.date, inSameDayAs: date) }?.budget
    }

    // 특정 날짜가 현재 월에 속하는지 확인하는 함수
    func isDateInCurrentMonth(_ date: Date, currentMonth: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.year, from: date) == calendar.component(.year, from: currentMonth) &&
               calendar.component(.month, from: date) == calendar.component(.month, from: currentMonth)
    }

    // 날짜 선택 로직을 처리하는 함수
    func selectDate(_ date: Date) {
        guard isDateInCurrentMonth(date, currentMonth: currentMonth) else { return }

        if let firstDate = firstSelectedDate, Calendar.current.isDate(date, inSameDayAs: firstDate) {
            return
        } else if firstSelectedDate == nil {
            firstSelectedDate = date
        } else if secondSelectedDate == nil {
            secondSelectedDate = date
        } else {
            firstSelectedDate = date
            secondSelectedDate = nil
        }
    }

    // 선택된 날짜들을 반환하는 함수
    func selectedDates() -> (Date?, Date?) {
        return (firstSelectedDate, secondSelectedDate)
    }

    // 날짜를 문자열로 변환하는 함수
    func dateString(from date: Date?) -> String {
        guard let date = date else { return "선택해주세요" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
}

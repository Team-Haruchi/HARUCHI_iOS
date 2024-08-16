import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var calendarData: [CalendarModel] = []
    @Published var firstSelectedDate: Date?
    @Published var secondSelectedDate: Date?
    @Published var currentMonth: Date = Date()

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchCalendarData()
        setupBindings()
    }

    // 샘플 데이터를 생성하는 함수
    func fetchCalendarData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 샘플 데이터 생성
        calendarData = [
            CalendarModel(date: dateFormatter.date(from: "2024-08-15")!, budget: 2000000),
            CalendarModel(date: dateFormatter.date(from: "2024-08-16")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-08-30")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-08-01")!, budget: 2000000),
            CalendarModel(date: dateFormatter.date(from: "2024-08-02")!, budget: 2000000),
            CalendarModel(date: dateFormatter.date(from: "2024-08-03")!, budget: 20000),
            // ... 추가 데이터
        ]
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

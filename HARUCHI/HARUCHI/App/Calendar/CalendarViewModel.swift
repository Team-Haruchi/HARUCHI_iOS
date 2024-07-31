import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var calendarData: [CalendarModel] = []
    @Published var firstSelectedDate: Date?
    @Published var secondSelectedDate: Date?

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchCalendarData()
    }

    // 샘플 데이터를 생성하는 함수
    func fetchCalendarData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 샘플 데이터 생성
        calendarData = [
            CalendarModel(date: dateFormatter.date(from: "2024-06-15")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-06-16")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-06-30")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-07-01")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-07-02")!, budget: 20000),
            CalendarModel(date: dateFormatter.date(from: "2024-07-03")!, budget: 20000),
            // ... 추가 데이터
        ]
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
        if let firstDate = firstSelectedDate, Calendar.current.isDate(date, inSameDayAs: firstDate) && secondSelectedDate == nil{
            firstSelectedDate = nil
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
        guard let date = date else { return "None" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

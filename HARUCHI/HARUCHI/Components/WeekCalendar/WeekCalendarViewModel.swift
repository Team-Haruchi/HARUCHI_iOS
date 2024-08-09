import SwiftUI

class WeekCalendarViewModel: ObservableObject {
    @Published var weekData: [WeekCalendarModel] = []
    
    @Published var currentPage: Date = Date() {
        didSet {
            updateHeaderTitle()
        }
    }
    @Published var headerTitle: String = ""

    init() {
        setupDummyData()
        updateHeaderTitle()
    }
    
    func setupDummyData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        weekData = [
            WeekCalendarModel(date: formatter.date(from: "2024-08-05")!, icon: "calendar_smiling", value: 0),
            WeekCalendarModel(date: formatter.date(from: "2024-08-06")!, icon: "calendar_pouting", value: 0),
            WeekCalendarModel(date: formatter.date(from: "2024-08-07")!, icon: "calendar_smiling", value: 0),
            WeekCalendarModel(date: formatter.date(from: "2024-08-08")!, icon: "calendar_base", value: 20000),
            WeekCalendarModel(date: formatter.date(from: "2024-08-09")!, icon: "calendar_base", value: 20000),
            WeekCalendarModel(date: formatter.date(from: "2024-08-10")!, icon: "calendar_base", value: 20000),
            WeekCalendarModel(date: formatter.date(from: "2024-08-11")!, icon: "calendar_base", value: 20000),
        ]
    }
    
    func updateHeaderTitle() {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: currentPage)
        let month = calendar.component(.month, from: currentPage)
        let monthName = DateFormatter().monthSymbols[month - 1]
        headerTitle = "\(month)월 \(weekOfMonth)째주"
    }
}

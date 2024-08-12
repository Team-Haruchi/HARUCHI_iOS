//
//  HomeViewModel.swift
//  HARUCHI
//
//  Created by 채리원 on 7/31/24.
//

import SwiftUI

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
    
    
    var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    init() {
        setupDummyData()
        updateCurrentMonth()
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func setupDummyData() {
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
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) {
                // 데이터 에시로 넣어둠, 나중에 네트워크 연결하면서 수정필요
                let iconName = ["calendar_smiling", "calendar_pouting", "calendar_base"].randomElement() ?? "calendar_base"
                let value = [0, 20000].randomElement()
                
                let model = WeekCalendarModel(date: date, icon: iconName, value: value)
                weekData.append(model)
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

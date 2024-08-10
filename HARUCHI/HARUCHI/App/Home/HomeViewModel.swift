//
//  HomeViewModel.swift
//  HARUCHI
//
//  Created by 채리원 on 7/31/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var money = ""
    @Published var selectedType: String = "미분류"
    @Published var selectedCategory: String = "미분류"
    @Published var selectedIncome: String = "미분류"
    @Published var showIncomeSheet: Bool = false
    @Published var upSpendSheet: Bool = false
    @Published var navigateToReceipt: Bool = false
    @Published var navigateToHomeMain: Bool = false
    @Published var showMainButton: Bool = false
    @Published var weekData: [WeekCalendarModel] = []
    
    
    init() {
        setupDummyData()
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
}

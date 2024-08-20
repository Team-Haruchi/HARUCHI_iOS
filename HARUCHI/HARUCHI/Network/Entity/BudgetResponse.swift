//
//  BudgetResponse.swift
//  HARUCHI
//
//  Created by 이상엽 on 8/14/24.
//

import Foundation

struct BudgetResponse: Decodable {
    let dayBudget: Int
}

struct SafeBoxResponse: Decodable {
    let safeBox: Int
}

struct DateBudgetResponse: Decodable {
    let budget: [BudgetItem]
}

struct BudgetItem: Decodable {
    let day: Int
    let dayBudget: Double
}

struct MonthBudgetResponse: Decodable {
    let monthBudget: Int
}

struct LeftNowResponse: Decodable {
    let leftDay: Int
    let leftBudget: Int
}

struct BudgetPercentResponse: Decodable {
    let monthUsedPercent: Int
}

struct WeekBudgetResponse: Decodable {
    let weekBudget: [WeekBudgetItem]
}

struct WeekBudgetItem: Decodable {
    let day: Int
    let dayBudget: Int
    let status: String
}

